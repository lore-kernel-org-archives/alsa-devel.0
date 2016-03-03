From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 3 Mar 2016 10:20:55 -0600
Message-ID: <56D86467.9030703@linux.intel.com>
References: <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org> <20150615164623.GA693@asus>
 <1434387868.2434.50.camel@loki> <20150623090932.GA6856@dellaz>
 <20150624102157.GL19530@localhost> <20150624182120.GA481@asus>
 <20150625032407.GQ19530@localhost> <20160303111110.GA13202@acervm>
 <20160303112745.GJ11154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 466A126655C
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 17:20:58 +0100 (CET)
In-Reply-To: <20160303112745.GJ11154@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Michele Curti <michele.curti@gmail.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, ao2@ao2.it, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 3/3/16 5:27 AM, Vinod Koul wrote:
> On Thu, Mar 03, 2016 at 12:11:10PM +0100, Michele Curti wrote:
>> Hi Vinod,
>>
>> On Thu, Jun 25, 2015 at 08:54:07AM +0530, Vinod Koul wrote:
>>>> [    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
>>> this is unexpected, I will check on this
>>>
>>>> ...
>>>> [    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
>>>> [    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
>>> Yes this is a problem, which FW are you using
>
> Have you tried the recent kernels, Pierre did a bunch of update and got many
> things working.
>
> As for timeout, that simply means we have send a message to DSP which failed
> to get a response. Perhpas the message had some bad element of FW had a
> bug/crashed...

The firmware timeout is due to a change in the BIOS for BYT-CR devices 
that impacts the IPC interrupt number, I have a set of patches that fix 
this on Asus T100TAF but I still can't get any sound out.
