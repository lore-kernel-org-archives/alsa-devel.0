From: Remy Bruno <remy.bruno@libertysurf.fr>
Subject: hwparams question
Date: Thu, 14 Nov 2002 17:11:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021114171149.A21129@immersivesound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I sent a mail some times ago, but maybe it was not very clear.

I wonder how it is possible to change the hwparams after having opened a
playback or capture stream. I tried to close and re-open the streams, but it
crashed (at least with 0.9.0beta10). What are the functions to call to change
hwparams, like the number of channels? And how is it possible to link a stream
to another after one of them has been run? (snd_pcm_link() requires that the
stream be in a specific state, and I don't know how to reach this state again
after the stream has been run) I didn't find examples where this is done...

Thanks in advance.


Best regards,
Remy Bruno


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
