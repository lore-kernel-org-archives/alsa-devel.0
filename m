From: "Andreas Kuckartz" <A.Kuckartz@ping.de>
Subject: Re: Re: [Alsa-devel] Bugtracking system
Date: 21 Jan 2004 13:26:52 +0100
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <01dc01c3e019$da571450$a501a8c0@computer2>
References: <Pine.LNX.4.44.0401210251440.30081-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Dan Hollis <goemon@anime.net>, 	Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, 	 <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have no doubt that Mantis is a good system and I might even concede that
it is superior to Bugzilla. But I prefer to reuse the Bugzilla system at
kernel.org for these reasons:

1. Nobody has yet volunteered to setup and maintain Mantis or Bugzilla for
ALSA purposes.

2. ALSA is closely related with the kernel (especially since version 2.6).
It therefore makes some sense to track ALSA issues together with (other)
kernel issues. This makes it easy to link to other kernel bugs or move bugs
to other Categories.

3. It is probably much easier to add a Category "Sound" to
bugzilla.kernel.org with a suitable list of Components than to create and
maintain a new Bugzilla or Mantis installation just for ALSA.

In other words: this approach enables the ALSA project to use networking
effects.

Of course this approach also has disadvantages. One of them is that the
treatment of version numbers (kernel versus ALSA) is not obvious. But I
think that this does not prevent the use of bugzilla.kernel.org for ALSA.
The Version field is configured as a free form field. Those who enter bugs
for ALSA should either enter the kernel version or a combination of kernel
version and ALSA version. The second alternative would (hopefully) be used
by those people who create their own kernels.

In case the proposal is accepted and nobody has connections to the
maintainers of kernel.org I would volunteer to ask the bugzilla.kernel.org
maintainer to add a new Category "Sound" with a small number of Components
(suggestions?).

Andreas

----- Original Message ----- 
From: "Dan Hollis" <goemon@anime.net>
To: "Andreas Kuckartz" <A.Kuckartz@ping.de>
Cc: <alsa-user@lists.sourceforge.net>; <alsa-devel@lists.sourceforge.net>
Sent: Wednesday, January 21, 2004 11:56 AM
Subject: [Alsa-user] Re: [Alsa-devel] Bugtracking system


> On 21 Jan 2004, Andreas Kuckartz wrote:
> > I clearly prefer Bugzilla to the sourceforge bugtracking system.
>
> I can't stand bugzilla or sourceforge bugtracker.
>
> I searched a long time for a good bugtracker, tried many different ones
> before I decided on mantis: http://mantisbt.sourceforge.net/
>
> It's much more straightforward than bugzilla, far more powerful than
> sourceforge, much much easier to use, and very easy to install.
>
> -Dan



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
