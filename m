From: "Loc Ho" <loc@pacificconsultants.com>
Subject: ALSA USB Audio Driver
Date: Fri, 14 May 2004 14:46:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <D22B281CC561444AA27F7F6C6C9E3E6102F564@mtvs4.pcllc.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Hi,

I am using the Linux 2.6.4 version of the ALSA (1.0.2c). Apparently, the =
ALSA USB Audio driver doesn't cleanup properly when it is disconnected =
while the streams are not closed. For example, perform a loop back =
(record and playback) for 1 minute and then disconnect. If you =
disconnect, there will be a bunch of error messages printed from the URB =
call back (or retire_xxx) function. I don't believe that there is any =
change in the ALSA USB Audio driver to handle this in the current =
version Linux 2.6.6. Have any one tried this? Or, this only happens on =
the ARM architecture? The fix that I made is to return an error code and =
stop submitting URB if there is any error.


Thanks,
Loc


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
