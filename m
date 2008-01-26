From: Nigel Henry <cave.dnb@tiscali.fr>
Subject: Re: Broken seq
Date: Sat, 26 Jan 2008 18:07:35 +0100
Message-ID: <200801261807.35265.cave.dnb@tiscali.fr>
References: <200801261250.58032.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 902AC103908
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 18:07:38 +0100 (CET)
Received: from [192.168.0.230] (213.36.166.86) by mail.libertysurf.net
	(7.3.118.8) id 478BC985003545A2 for alsa-devel@alsa-project.org;
	Sat, 26 Jan 2008 19:07:07 +0100
In-Reply-To: <200801261250.58032.gineera@aspect135.co.uk>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 26 January 2008 13:50, Alan Horstmann wrote:
> Can someone help with this...
>
> During repeated testing of MIDI, something has broken the seq system, so
> when loading previously working sound drivers, I get a message:
>
>  /proc/asound/seq/clients   File not found
>
> (or similar) and sure enough it is not there.
>
> Why has it gone and how can I get it back?
>
> Thanks  Alan

Hi Alan. I don't know too much, but try doing a:
modprobe snd-seq  (as root obviously)

Does it now show up in lsmod?

Which distro are you using?

Nigel.
