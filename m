From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Notebook Toshiba satellite x200-21g with
	realtek	snd-hda-intel audio device still not supported (codec
	ALC268)
Date: Wed, 26 Dec 2007 13:13:51 -0800
Message-ID: <1198703631.3732.187.camel@razman.gruemaster.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>
	<476A2BCC.4060109@gmail.com> <s5h1w9h4g5d.wl%tiwai@suse.de>
	<47727C6C.6080401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7714049806179733266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id CD7D62491F
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 22:13:53 +0100 (CET)
In-Reply-To: <47727C6C.6080401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7714049806179733266==
Content-Type: multipart/related; type="multipart/alternative"; boundary="=-0L2qAYfnyExAVJZHZmxm"


--=-0L2qAYfnyExAVJZHZmxm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I haven't forgotten about you (yet).  :)

I'll look at getting you a patch this week.  Work is scheduled to be
very slow due to the holidays.

Tobin

On Wed, 2007-12-26 at 17:08 +0100, Daniele (Mastro) wrote:

> Takashi Iwai ha scritto:
> > I recommend you to hack the driver code by yourself.
> > The coding itself isn't too difficult.  The problem is the guess work,
> > which PIN really corresponds to which I/O, and what control is missing
> > (EAPD, GPIO, etc).
> 
> hum..
> i guess the file i should edit is patch_realtek.c
> but i really have no idea on what to change/add and how to understand
> what i have to change...
> 
> in my other message there are the debug info you requested and i don't
> know how to use them
> 
> i'm really want to do something to help you but i keep reading the code
> without knowing what to do or understanding it very much... i never
> developed kernel drivers and I've no idea on what to do
> 
> I'm putting here my good will but think i miss the knowledge to do what
> you suggested and i don't know where to achieve it either
> 
> > What I'm wondering is how to support 5.1 output.  The ALC268 codec is
> > at most for 4 channels (2 + 2).  Are you sure that you can get 5.1
> > distinct outputs?
> 
> probably this isn't a 5.1 as i said in the other message
> 
> thanks for any reply you will give me
> i'm sorry i'm so annoying


-- 
Tobin Davis <tdavis@dsl-only.net>

--=-0L2qAYfnyExAVJZHZmxm
Content-ID: <1198703629.3732.185.camel@razman.gruemaster.com>
Content-Disposition: attachment; filename=smiley-3.png
Content-Type: image/png; name=smiley-3.png
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAC+klEQVR42n2TbUjVdxTHP/+H69Xd
a2VWlFe69rzthZJUoxeNOWoFGxEhYRRFmZSVW2u9ab2KejWE1qDNBkEQhS82VoiaZkVPmoWaKNM5
mA+opbd771//997//T/+epHBarEPHA6Hc84XDnwP/JcwcBS4AVgzcR04ONN7C+md+pcPCz44dPLA
arZs/gg1UABuGkvvp7X1Iad+itE/YtUAle8TuH26sujzqq/LkJQsnOQQVmIASVJQMhehZORiJwc5
d76FH2pf3gY2Aigzy7+eObqmtOqbXbjGGHZqCM+eQpJ9AHhWFCc5CAjWf1KAkppc+qg3vRCol4Fw
0aqcisOVW3HTE7hmBElSKD/5GFkNMhH1KDvegST78CwNSfZxeM88VuYrh4CwAuxqvxL6MnPuWiy9
H1kNUPH9fZofDKPpHn8/z+Z6Yw8JK5stX5VhRO6h+OfiV3WaHxtPVKAwmF+KqXUDMkgqZ0+UoKcE
P57/GXOqh46ODqrPXUQfufb6YOGxJOQD2CaHQnnlAJ4zDXggHBYvK6ap6Rau+RIz1k7djd+YHrqM
pXUC4KQnWTRPAdiuRqNRkFQG/omRNJOsKVQw408xtS4QDsI10AaqEY6O8Fzq70fJy3XI8gsA5HTa
rBdOkvwFKj39EWrr/sJzEnj29OvsphGugfBsLlwbZnjcYN36LxiLuADtMtCUetFAcE4ee8s+pbHV
YtOemwhHx3MSaPEY3X9OUnqsk5a2OMeP7KC3t4u+3gRALUC4cEW2eN62Q4ze3SAiz74TDxvOiI+X
BcTsoCoyfJKYn6OKmrMbxGRnlXhyJSSqv80Vq0KSAFa+ceKl0wcK9lfsW42TGsE/pxhfcDmKfz6e
FUPg4iRH6Ov6g9EJh1t341xusWuAyn9b+c7BrbklJ8oDZGTOQpL9ePY08SmDpCEwbcHwuE370yku
Nlj3gM/e90yXliyU9+8sCVJYlEUgU8IwBZruMThm83uzxsAYV4Hd/A9h4BjQBthAFOgDLgDF7w6/
ArI6YJ0eTQeGAAAAAElFTkSuQmCC


--=-0L2qAYfnyExAVJZHZmxm--


--===============7714049806179733266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7714049806179733266==--
