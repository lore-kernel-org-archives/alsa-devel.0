From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
Subject: Cards and PCM instances
Date: Thu, 16 Feb 2006 21:15:06 -0800
Message-ID: <BAY111-DAV13EC412102C661A02696E1C2F80@phx.gbl>
References: <20060216114804.698A289A8A@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In "Writing an ALSA driver", the author has mentioned that each card can
have upto 4 PCM instances.

Does a PCM instance correspond to an independent audio output ?

For e.g, in the project I am working the hardware  has 2 audio outputs that
would be used to render 2 separate PCM streams at the same time, would this
configuration correspond to 2 different PCMs or to 2 different cards ?

Thanks,
Nikhil


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
