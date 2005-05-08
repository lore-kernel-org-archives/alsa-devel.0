From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: alsa-driver failes to build correctly.
Date: Sun, 08 May 2005 23:36:34 +0100
Message-ID: <427E9472.7080107@superbug.co.uk>
References: <427E8FC6.6080900@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <427E8FC6.6080900@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Hi,
> 
> if one downloads the latest cvs of alsa-driver,alsa-kernel and does
> 
> ./configure --with-cards=usb-audio
> 
> It fails to build module "snd-hwdep", and so when one does "modprobe
> snd-usb-audio" if fails with unknown symbols.
> 
> But, if one builds with:
> ./configure --with-cards=emu10k1,usb-audio
> it works fine.
> 
> Can anyone find out why?
> 
> James
> 

OK, I fixed it in CVS now.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
