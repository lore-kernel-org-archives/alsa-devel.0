From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1
 works, alsa-driver-1.0.9rc2 doesn't
Date: Wed, 30 Mar 2005 22:26:05 +0100
Message-ID: <424B196D.6060004@superbug.co.uk>
References: <20050330213009.41195.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050330213009.41195.qmail@web52901.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris Rankin wrote:
> I've just compared the results with the alsa-driver-1.0.9rc1 and alsa-driver-1.0.9rc2 tarballs
> with my Audigy2 sound card.
> 
> The summary: I can record via the microphone with rc1, but can't with rc2.
> 
> The command I'm using is:
> 
> $ arecord -d10 -f cd -t wav > test.wav
> 
> Cheers,
> Chris
> 
> 

What does cat /proc/asound/cards  output?



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
