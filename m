From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Recording on an Audigy?
Date: Thu, 20 Jan 2005 17:13:38 -0500
Message-ID: <41F02D12.5050807@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


I'm trying to record from the line-in on my Audigy.  After messing with 
alsamixer in vain for a while, I finally googled for the answer and came 
across this page:

http://alsa.opensrc.org/index.php?page=emu10k1

It says:

Recording from analog sources:
All analog sources are mixed together and only this mix can by recorded.
Analog Mix Capture Volume controls capture volume for this mix.
You can monitor what you are recodring using Analog Mix Playback Volume 
control.

Except that with at least versions 1.0.7 and 1.0.8 I don't have an 
Analog Mix Capture Volume, just a Playback Volume.  Any idea what's 
going on?  Is this a bug?

Adam



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
