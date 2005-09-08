From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Converting OSS ioctl's to ALSA API
Date: Thu, 8 Sep 2005 14:54:26 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509081450540.19696-100000@studcom.urz.uni-halle.de>
References: <431F69D3.1060705@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <431F69D3.1060705@superbug.co.uk>
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
Cc: Bob Ingraham <bobi@netshel.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> If you open plughw:0,0 for only playback, and then again for only
> capture it should work.

It should be noted that this is the _only_ way you can use such a
device, as snd_pcm_open() opens only one direction at a time.

Your application just shouldn't care if the playback and capture
devices happen to have the same name.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
