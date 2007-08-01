From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH alsa-driver asihpi] Fix StreamGetInfo
Date: Thu, 02 Aug 2007 10:35:23 +1200
Message-ID: <200708021035.23240.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 58DB8103820
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 00:35:15 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JM400J6F9EBH230@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 02 Aug 2007 10:35:00 +1200 (NZST)
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

StreamGetInfo queried wrong stream type.
(minor) correct case of Playback and Capture control names

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---

diff -r a2861559e4ed pci/asihpi/asihpi.c
--- a/pci/asihpi/asihpi.c       Fri Jul 27 08:54:15 2007 +1200
+++ b/pci/asihpi/asihpi.c       Thu Aug 02 10:25:24 2007 +1200
@@ -228,11 +228,11 @@ static inline u16 HPI_StreamGetInfoEx(HP
                                      u32 * pdwAuxiliaryData)
 {
        if (HPI_HandleObject(hStream) == HPI_OBJ_OSTREAM)
-               return HPI_InStreamGetInfoEx(hS, hStream, pwState,
+               return HPI_OutStreamGetInfoEx(hS, hStream, pwState,
                                             pdwBufferSize, pdwDataInBuffer,
                                             pdwSampleCount, pdwAuxiliaryData);
        else
-               return HPI_OutStreamGetInfoEx(hS, hStream, pwState,
+               return HPI_InStreamGetInfoEx(hS, hStream, pwState,
                                              pdwBufferSize, pdwDataInBuffer,
                                              pdwSampleCount, pdwAuxiliaryData);
 }
@@ -1201,7 +1201,7 @@ struct hpi_control {
 #define ASIHPI_SOURCENODE_STRINGS \
 { \
        TEXT("no source"), \
-       TEXT("PCM playback"), \
+       TEXT("PCM Playback"), \
        TEXT("Line in"), \
        TEXT("Digital in"), \
        TEXT("Tuner"), \
@@ -1230,7 +1230,7 @@ struct hpi_control {
 #define ASIHPI_DESTNODE_STRINGS \
 { \
        TEXT("no destination"), \
-       TEXT("PCM capture"), \
+       TEXT("PCM Capture"), \
        TEXT("Line out"), \
        TEXT("Digital out"), \
        TEXT("RF"), \
