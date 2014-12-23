From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [PATCH] sound: pci: asihpi: hpifunc.c: Remove some unused functions
Date: Tue, 23 Dec 2014 17:16:37 +1300
Message-ID: <5498ECA5.2050802@blennerhassett.gen.nz>
References: <1419180627-8986-1-git-send-email-rickard_strandqvist@spectrumdigital.se> <54974A66.8010209@blennerhassett.gen.nz> <CAFo99gazBQ=dYJX=2484m0ZydTZ9FRetPHdj=sgAVogtsxzfvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFo99gazBQ=dYJX=2484m0ZydTZ9FRetPHdj=sgAVogtsxzfvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 23/12/14 10:41, Rickard Strandqvist wrote:
> Hi Eliot!
> 
> This is one of the largest remove patches I made.
> Is it just one function you disagree with?

Yes.  If you generate the patch against for-next branch I guess that
function will not be removed because it is used by the new code.
> 
> Then I obviously send a new Patch!
> Will be busy few days, but then I send a new one.
> 
> Kind regards
> Rickard Strandqvist
> 
> 
> 2014-12-21 23:32 GMT+01:00 Eliot Blennerhassett <eliot@blennerhassett.gen.nz>:
>> On 22/12/14 05:50, Rickard Strandqvist wrote:
>>> Removes some functions that are not used anywhere:
>>
>> NAK - because  hpi_adapter_set_property() is now used in for-next branch
>> of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>
>> Otherwise I have no problem with the patch.


-- 
Eliot
