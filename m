From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Tue, 07 Jul 2015 10:00:31 -0400
Message-ID: <559BDB7F.9010105@gmail.com>
References: <8D3F6266AEB6384E807C6FFC6FE195E30B49AE39@BGSMSX101.gar.corp.intel.com>
 <20150703143608.7afb34c985d82982e929484e@ao2.it>
 <20150703130658.GA1689228@phare.normalesup.org> <559A90CE.2030105@gmail.com>
 <20150707031950.GD11002@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E2ED26587F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 16:00:33 +0200 (CEST)
Received: by qget71 with SMTP id t71so84425275qge.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2015 07:00:32 -0700 (PDT)
In-Reply-To: <20150707031950.GD11002@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

Vinod,

I am using the ssp0 firmware from:
https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/tree/intel?h=byt.

Thanks-

Tyler

On 07/06/2015 11:19 PM, Vinod Koul wrote:
> On Mon, Jul 06, 2015 at 10:29:34AM -0400, Tyler Yeomans wrote:
>> Hello all,
>>
>> Apparently I'm in the same boat as Nicolas is.
>> I've attached my dmesg output.
>> Everything seems to be generating but I am not able to get any sound
>> output.
>> Between the 37 second mark and the 617 second mark I had routed the
>> FE to BE via the commands:
>>
>> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
>> amixer -c0 sset 'media0_out mix 0 media1_in' on
> ok that seems fine
>> Although it appears that did not work:
>> [  719.834922] intel_sst_acpi 80860F28:00: Wait timed-out
>> condition:0x0, msg_id:0x1 fw_state 0x3
>> [  719.834932] intel_sst_acpi 80860F28:00: fw returned err -16
> I don't think so, since you were able to start the card, that part worked :)
>
> The error is coming from FW here and seems unresponsive.
>
> Which firmware are you using?
>
> Second suspicion is for interrupts, if they are not mapped well we might see
> these.
>
> Jarkko I remember that some board have to be configured properly for
> interrupts, can you explaian the subtleties involved here
>
> --
> ~Vinod
