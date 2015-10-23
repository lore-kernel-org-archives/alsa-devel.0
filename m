From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 8/8] ASoC: AMD: add AMD ASoC ACP-I2S driver
Date: Fri, 23 Oct 2015 16:39:07 -0400
Message-ID: <CADnq5_M_XyTgyfCpSfA77ce-rFCkRJg6VkfPWriEHNkRbU8m-Q@mail.gmail.com>
References: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
 <20151022161415.GU8232@sirena.org.uk>
 <CANv6ZMY_8MzZK0StdgAnzN7EqZVJ3tMz88pKACb3sGKXmRTtXQ@mail.gmail.com>
 <20151023193152.GL29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D904264F30
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 22:39:09 +0200 (CEST)
Received: by ykba4 with SMTP id a4so126372136ykb.3
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 13:39:08 -0700 (PDT)
In-Reply-To: <20151023193152.GL29919@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, maruthi srinivas <maruthi.srinivas.b@gmail.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 23, 2015 at 3:31 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Oct 24, 2015 at 12:20:09AM +0530, maruthi srinivas wrote:
>> On Thu, Oct 22, 2015 at 9:44 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Thu, Oct 08, 2015 at 12:12:40PM -0400, Alex Deucher wrote:
>
>> >> +/* ACP DMA irq handler routine for playback, capture usecases */
>> >> +int dma_irq_handler(struct device *dev)
>> >> +{
>> >> +     u16 dscr_idx;
>> >> +     u32 intr_flag;
>> >
>> > This says it's an interrupt handler but it's using some custom,
>> > non-genirq interface?
>
>> Irq handling is based on parent device's (part of other subsystem)
>> provided interfaces. I will coordinate with others for this.
>
>> Do you mean, using virtual irq assignment for MFD devices
>> (ACP is a MFD device) and registering irq handler for it ?
>
> Well, I'd expect that if we're exporting interrupts around the system
> we'd be doing so using genirq rather than open coding something.

I think the problem is, that in a lot of cases, it's not always
readily clear that there is an existing infrastructure to do
something.  In this particular case, most of the common infrastructure
that should be utilized for this particular patch set comes from
non-traditional x86 platforms so most of us that come from a more
traditional x86 background as not as familiar with them.  Searching
for information on how to solve these does not always produce
particularly useful results (e.g., genirq).  So we end up open coding
a solution, not out of malice, but ignorance.  If there is
infrastructure we should be using, please continue to point it out
during code review and we'll do our best to take advantage of it.

In the case of this hardware, audio interrupts are triggered on the
GPU.  The GPU driver's interrupt handler checks the interrupt source
and calls the handler registered to handle that source.  Until now the
ACP audio block was added, all the GPU interrupt sources were stuff
handled directly by the GPU driver (vblanks, display hotplug, command
submission fences, etc.).

Thanks,

Alex


>
>> >> +             /* Let ACP know the Allocated memory */
>> >> +             num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> >> +
>> >> +             /* Fill the page table entries in ACP SRAM */
>> >> +             rtd->pg = pg;
>> >> +             rtd->size = size;
>> >> +             rtd->num_of_pages = num_of_pages;
>> >> +             rtd->direction = substream->stream;
>
>> > We never reference num_of_pages other than to assign it into the page
>> > table entry?
>
>> Sorry, I didn't understand your comment.
>> I used 'num_of_pages' to configure ACP audio device for accessing system
>> memory. The implementation is in 'acp_pte_config' function in the patch.
>
> In the above code we have two blocks of code, one doing an assignment to
> a local variable and the other initialising the struct but the local
> variable in the first block is only ever referenced in the second block.
>
>> >> +static int acp_dma_close(struct snd_pcm_substream *substream)
>> >> +{
>> >> +     struct snd_pcm_runtime *runtime = substream->runtime;
>> >> +     struct audio_substream_data *rtd = runtime->private_data;
>> >> +     struct snd_soc_pcm_runtime *prtd = substream->private_data;
>
>> >> +     kfree(rtd);
>
>> >> +     pm_runtime_mark_last_busy(prtd->platform->dev);
>
>> > Why the _mark_last_busy() here?
>
>> I want to power off ACP audio IP, when the audio usecase is not active for
>> sometime (run time PM). I felt, 'close' is the correct place to mark this.
>
> That's not what _mark_last_busy() does...  the core already takes
> runtime PM references for you.
>
>> >> +static int acp_pcm_suspend(struct device *dev)
>> >> +{
>> >> +     bool pm_rts;
>> >> +     struct audio_drv_data *adata = dev_get_drvdata(dev);
>> >> +
>> >> +     pm_rts = pm_runtime_status_suspended(dev);
>> >> +     if (pm_rts == false)
>> >> +             acp_suspend(adata->acp_mmio);
>> >> +
>> >> +     return 0;
>> >> +}
>
>> > This appears to merely call into the parent/core device (at least it
>> > looks like this is the intention, there's a bunch of infrastructure fo
>> > the core device which appeaars to replicate standard infrastructure).
>> > Isn't whatever this eventually ends up doing handled by the parent
>> > device in the normal PM callbacks.
>
>> ACP device (child) can power off itself, when it receives suspend
>> request. So, the intention is to call 'acp_suspend' (defined in same patch)
>> from the 'suspend' callback of ACP device.
>
> This doesn't address why you're open coding this rather than using
> standard infrastructure.
>
>> >> +     pm_rts = pm_runtime_status_suspended(dev);
>> >> +     if (pm_rts == true) {
>> >> +             /* Resumed from system wide suspend and there is
>> >> +              * no pending audio activity to resume. */
>> >> +             pm_runtime_disable(dev);
>> >> +             pm_runtime_set_active(dev);
>> >> +             pm_runtime_enable(dev);
>> >
>> > The above looks very strange - why are we bouncing runtime PM like this?
>>
>> Sorry, I didn't understand your comment. I felt, steps mentioned in
>> kernel documentation :
>> http://lxr.free-electrons.com/source/Documentation/power/runtime_pm.txt#L634
>> is applicable in this scenario. I maybe wrong, but felt that is applicable.
>
> Please document this clearly - your comment doesn't appear to relate to
> the case where system resume powers things on at all.
>
>> >> +/* Initialize the dma descriptors location in SRAM and page size */
>> >> +static void acp_dma_descr_init(void __iomem *acp_mmio)
>> >> +{
>> >> +     u32 sram_pte_offset = 0;
>> >> +
>> >> +     /* SRAM starts at 0x04000000. From that offset one page (4KB) left for
>> >> +      * filling DMA descriptors.sram_pte_offset = 0x04001000 , used for
>
>> > This is a device relative address rather than an absolute address?  A
>> > lot of these numbers seem kind of large...
>
>> That is SRAM block's offset address. Sorry. I didn't understand the
>> expected change, here.
>
> Offset with regard to what?  I'm asking if these addresses are within
> the IP or global.
>
>> >> +/* power off a tile/block within ACP */
>> >> +static void acp_suspend_tile(void __iomem *acp_mmio, int tile)
>> >> +{
>> >> +     u32 val = 0;
>> >> +     u32 timeout = 0;
>> >> +
>> >> +     if ((tile  < ACP_TILE_P1) || (tile > ACP_TILE_DSP2))
>> >> +             return;
>> >> +
>> >> +     val = acp_reg_read(acp_mmio, mmACP_PGFSM_READ_REG_0 + tile);
>> >> +     val &= ACP_TILE_ON_MASK;
>
>> > This is definitely looking like a SoC that could benefit from the
>> > standard kernel power management infrastructure and/or DAPM.  There's a
>> > lot of code here that looks like it's following very common SoC design
>> > patterns and could benefit from using infrastructure more.
>
>> Sorry, I didn't understand. Could you help in adding more pointers on this.
>> The device can get powered-off, with this helper function, which can
>> be called from device 'suspend' callback.
>
> Power domains are implemented using the interface in include/linux/pm_domain.h
> and DAPM is sound/soc/soc-dapm.c.  The point here is that it looks very
> much like you are open coding implementations of concepts that we
> already have generic support for which adds greatly to both the size and
> complexity of this code.
>
>> >> +static void acp_turnoff_sram_banks(void __iomem *acp_mmio)
>> >> +{
>> >> +     /* Bank 0 : used for DMA descriptors
>> >> +      * Bank 1 to 4 : used for playback
>> >> +      * Bank 5 to 8 : used for capture
>> >> +      * Each bank is 8kB and max size allocated for playback/ capture is
>> >> +      * 16kB(max period size) * 2(max periods) reserved for playback/capture
>> >> +      * in ALSA driver
>> >> +      * Turn off all SRAM banks except above banks during playback/capture
>> >> +      */
>> >> +     u32 val, bank;
>
>> > I didn't see any runtime management of the other SRAM bank power, seems
>> > like that'd be a good idea?
>
>> SRAM banks are part of ACP IP. With ACP's runtime PM handling, all blocks
>> within ACP IP can be powered-off and on.
>
> So why can't that cope with these banks then?
>
>> >> +/* Update DMA postion in audio ring buffer at period level granularity.
>> >> + * This will be used by ALSA PCM driver
>> >> + */
>> >> +u32 acp_update_dma_pointer(void __iomem *acp_mmio, int direction,
>> >> +                               u32 period_size)
>> >> +{
>
>> > Don't limit the accuracy to period level if the harwdare can do better,
>> > report the current position as accurately as possible please.  This is
>> > also feeling like we've got an unneeded abstraction here - why was this
>> > not just directly the pointer operation?
>
>> The current version of hardware has the limitation of accuracy reporting.
>
> If the hardware is limited why does the comment suggest that we are
> limiting based on periods?
>
>> I will remove abstraction, if suggested.
>
> Yes, it's just adding to the complexity of the code.
