From: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: 2.5.5-pre1 kernel - compile as modules?
Date: Fri, 15 Feb 2002 09:34:16 +0100
Message-ID: <E16bdov-0001iK-00@baldrick>
References: <XFMail.020215093035.guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from mel-rto6.wanadoo.fr (smtp-out-6.wanadoo.fr [193.252.19.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA22551
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 09:35:11 +0100
In-Reply-To: <XFMail.020215093035.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: curtisv@lineo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 15 February 2002 9:30 am, Guenther Sohler wrote:
> did you insmod the snd.o ???

Yes.  I have /proc/asound with all entries.  They just aren't
readable.  The soundcard is detected when I modprobe the
card module (nonetheless /proc/asound/cards is not readable:
no such device).  I have been using the CVS and other versions
of alsa with no problems, so this is presumably something to do
with the kernel sound patch.

Thanks for thinking about this,

Duncan.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
