From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: About my issue with the sound on a Dell Dimension
	4550.
Date: Thu, 21 May 2009 16:26:29 +0100
Message-ID: <20090521152629.GA2385@localhost>
References: <COL104-W1746D092576AD4FE96B684A75B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B12D2441F
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 17:10:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <COL104-W1746D092576AD4FE96B684A75B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer =?iso-8859-1?Q?Grundstr=F6m?= <khisbra@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2009 at 11:57:31PM +0200, Kristoffer Grundstr=F6m wrote:
> =

> What is the problem? I really want to know if it's about to be fixed. I'm=
 getting tired of having no sound.
> =

> https://qa.mandriva.com/show_bug.cgi?id=3D49048
>

If it works in Ubuntu 8.10 and 9.04 but not in Mandriva
(as described in the thread you linked to) the problem is caused
by whatever is different between the two distros. Finding what that
difference is would be a good first step. For example, what alsa driver
versions (as reported by `cat /proc/asound/version') do the working and
non-working distros use?

John
