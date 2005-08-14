From: Christian Esken <christian.esken-services@arcor.de>
Subject: Getting the ALSA driver version
Date: Mon, 15 Aug 2005 00:15:18 +0200
Message-ID: <200508150015.18838.christian.esken-services@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

for upcoming versions of KMix (the KDE Mixer Application), it will be possible to "tune"
KMix's visual appearance according to:

(1) the installed sound card
(2) the users preference
(3) the installed/running driver
(4) the driver version

While I am able to find out (1), (2) and (3), I haven't been able to find out (4): The runtime ALSA version.
More precisely, I am interested in the runtime ALSALIB version (but I reckon it is the same as the ALSA driver version in normal installations).

I cannot use /usr/include/alsa/version.h , because this is the version on which the
application is compiled (but not the runtime version).

Reading and parsing /proc/asound/version seems pretty crude, and I would like to avoid it, as it is error-prone.

Have I missed anything, or is it just not possible at the moment?

Chris

-- 
Is UNIX ready for the Desktop? See http://www.kde.org
KDE Developer: esken@kde.org


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
