From: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH 2/3] ALSA: hda - no-primary-hp is a quirk for model ALC889
 not ALC882
Date: Tue, 12 Feb 2013 18:42:59 +0900
Message-ID: <511A0EA3.2080506@lab.ntt.co.jp>
References: <1360655264.13766.2.camel@nexus.lab.ntt.co.jp> <1360655656.13766.6.camel@nexus.lab.ntt.co.jp> <s5ha9r9opap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha9r9opap.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2013/02/12 18:27, Takashi Iwai wrote:
> At Tue, 12 Feb 2013 16:54:16 +0900,
> Fernando Luis V=C3=A1zquez Cao wrote:
>> Substitute ALC889 for ALC882 in macro and function names.
>>
>> Cc: stable@vger.kernel.org
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> This fixup can work generically to all ALC882 variants, including
> ALC889.  Unless you are really sure that this must be used exclusivel=
y
> only for ALC889, no reason to change the prefix.

Thank you for applying patches 1 and 2 (I agree that
the second patch is not needed for stable).

Regarding this patch, I am not completely sure whether
this issue is ALC889 specific so we probably shouldn't
apply it as you say.

Regards,
=46ernando
