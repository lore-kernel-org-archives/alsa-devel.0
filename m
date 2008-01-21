From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Added mono mux mixer for some
 STAC92HD7XXX family codecs
Date: Mon, 21 Jan 2008 09:14:26 -0500
Message-ID: <4794A8C2.2090300@embeddedalley.com>
References: <47911DCA.9070104@embeddedalley.com>	<s5h4pdakva2.wl%tiwai@suse.de>	<4794A51C.6070709@embeddedalley.com>
	<s5h1w8be0a8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.mud.yahoo.com (smtp106.biz.mail.mud.yahoo.com
	[68.142.200.254]) by alsa0.perex.cz (Postfix) with SMTP id 413B7244F9
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 15:14:24 +0100 (CET)
In-Reply-To: <s5h1w8be0a8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 21 Jan 2008 08:58:52 -0500,
> Matthew Ranostay wrote:
>> Takashi Iwai wrote:
>>> At Fri, 18 Jan 2008 16:44:42 -0500,
>>> Matthew Ranostay wrote:
>>>> Some 92HD7XXX family codecs have a mono mux, added support for selecting the input path to the mono out.
>>>>
>>>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>> Could you fix the coding-style issues reported by checkpatch.pl?
>> Ok, fixed the 80-character lines it complained about, although I left the 'declaration in if statement' since
>> the code block below it does the same style.
> 
> Well, apprently you didn't run checkpatch.pl to the new patch? ;)
> 
> ERROR: do not use assignment in if condition (+		if ((err = stac92xx_auto_create_mono_output_ctls(codec)) < 0))
> #224: FILE: pci/hda/patch_sigmatel.c:2609:
> +		if ((err = stac92xx_auto_create_mono_output_ctls(codec)) < 0)
> 
I did but I didn't change it because the line below it does the same coding style.
But in that case I'll change both :)
> total: 1 errors, 0 warnings, 153 lines checked
> 
> 
> Takashi
> 
