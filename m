From: "Grygorii Tertychnyi (gtertych)" <gtertych@cisco.com>
Subject: Re: [PATCH] ALSA: msnd: Optimize / harden DSP and MIDI loops
Date: Fri, 8 Sep 2017 17:47:32 +0000
Message-ID: <1504892910570.67608@cisco.com>
References: <20170908160626.24771-1-gtertych@cisco.com>,<s5h377xqga2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h377xqga2.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

=0A=
>> Hi Greg,=0A=
>>=0A=
>> Could you please apply it for 4.4-stable.=0A=
>> This fixes https://nvd.nist.gov/vuln/detail/CVE-2017-9985=0A=
>=0A=
> This vulnerability is just non-issue.  You can't get it working=0A=
> practically; it requires a modified hardware of the decade old ISA=0A=
> sound card, and yet the system has to load / set up the module=0A=
> beforehand.  We should withdraw it from CVE, IMO.=0A=
=0A=
I think it is worth having it in 4.4, 4.9 and 4.12 also.=0A=
=0A=
>>=0A=
>> Takashi Iwai (1):=0A=
>>   ALSA: msnd: Optimize / harden DSP and MIDI loops=0A=
>>=0A=
>>  sound/isa/msnd/msnd_midi.c     | 30 +++++++++++++++---------------=0A=
>>  sound/isa/msnd/msnd_pinnacle.c | 23 ++++++++++++-----------=0A=
>>  2 files changed, 27 insertions(+), 26 deletions(-)=0A=
>>=0A=
