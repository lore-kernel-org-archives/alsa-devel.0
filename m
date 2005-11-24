From: Lee Revell <rlrevell@joe-job.com>
Subject: [RFC] Zero-conf ALSA
Date: Wed, 23 Nov 2005 23:03:44 -0500
Message-ID: <1132805024.1921.48.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I would like to gather a list of the work remaining to be done to
achieve "zero-conf" ALSA.  With the increasing maturity of dmix and
softvol we are very close to this goal, and should be able to provide
basic soundcard functionality that users expect (mixing, volume control,
and OSS emulation) without requiring them to delve into cryptic config
files.

I propose to open a tracking bug in the ALSA BTS to gather all reports
of end users having to modify the config to get a working setup.  AFAICT
the remaining problems are:

  1. Devices which require dmix and/or softvol but are lacking the required 
     entries in the /usr/share/alsa/cards/ file.
  2. User-space OSS emulation over dmix requires period and the buffer sizes 
     to be set to powers of two.

#1 can only be solved by gathering user reports.

Can #2 be solved by having dmix prefer power of two period/buffer sizes
for the slave hw PCM by default?  AFAICT this should work unless an ALSA
app has opened the device first and set an incompatible buffer size.

Are there currently any other cases where an end user would have to
create a custom ALSA config to enable basic functionality?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
