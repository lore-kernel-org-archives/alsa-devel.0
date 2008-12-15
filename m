From: "Alexander Chemeris" <Alexander.Chemeris@sipez.com>
Subject: Re: "No codecs found" on Intel HDA + AD1988A
Date: Tue, 16 Dec 2008 00:30:30 +0300
Message-ID: <3d032e5d0812151330j5e686f90g6a02637cca1d8ffc@mail.gmail.com>
References: <3d032e5d0812131057g71773bcam4b8a5832ea3bbba8@mail.gmail.com>
	<s5hskor15fj.wl%tiwai@suse.de>
	<3d032e5d0812151325o22945f7dy34ba87e6e9c955de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 754971037EF
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 22:30:31 +0100 (CET)
Received: by bwz13 with SMTP id 13so9495005bwz.8
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 13:30:30 -0800 (PST)
In-Reply-To: <3d032e5d0812151325o22945f7dy34ba87e6e9c955de@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 16, 2008 at 12:25 AM, Alexander Chemeris
<Alexander.Chemeris@sipez.com> wrote:
> On Sun, Dec 14, 2008 at 12:17 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Sat, 13 Dec 2008 21:57:04 +0300,
>> Alexander Chemeris wrote:
>> Anyway, try to build with --debug=verbose configure option.  Usually
>> you'll have a bit more messages.
>> At least, you'll get a message like "codec_mask = 0xxxx" at probing.
>> If the value is zero, it means that your hardware doesn't set the
>> codec slot bit, usually a BIOS issue.

Also interesting - I do not recall I updated BIOS this year.
How did it work earlier then?


-- 
Regards,
Alexander Chemeris.

SIPez LLC.
SIP VoIP, IM and Presence Consulting
http://www.SIPez.com
tel: +1 (617) 273-4000
