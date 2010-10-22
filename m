From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01 uploaded]
Date: Fri, 22 Oct 2010 20:53:26 +0100
Message-ID: <4CC1EBB6.5030500@colin.guthr.ie>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>	<4CBFEE94.7020103@gmail.com> <s5hlj5sc7do.wl%tiwai@suse.de>	<4CBFF25C.2080908@gmail.com> <s5hfww0c6oj.wl%tiwai@suse.de>	<4CC085F5.9070905@gmail.com> <4CC17629.6050703@ladisch.de> <s5h39ryxr25.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h39ryxr25.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 22/10/10 15:03 did gyre and gimble:
> At Fri, 22 Oct 2010 13:31:53 +0200,
> Clemens Ladisch wrote:
>>
>> Jiri Slaby wrote:
>>> On 10/21/2010 10:05 AM, Takashi Iwai wrote:
>>>>   commit de8c85f7840e5e29629de95f5af24297fb325e0b
>>>>     ALSA: HDA: Sigmatel: work around incorrect master muting
>>>
>>> Reverting this one helps.
>>
>> This one introduced even more wrong volume information on some codecs.
>> Pleasy try this patch on top:
> 
> Argh!  There is always a reason why we should define a constant.
> I applied the fix now.
> 
> This explains why the old patch worked on Colin's machine.
> His codec chip is different (STAC9200?), and it doesn't go in this
> code path but has a static Master volume creation.

Yup I have a STAC9200 so that explains it... silly me as I did see this
line and figured "the value will be right" rather than questioning it.

Anyway, glad this has been found and there is now (presumably) no need
for a revert :)

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
