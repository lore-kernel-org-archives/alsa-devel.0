From: Ren Brian <ren.brian@gmail.com>
Subject: How can i solve the alsa underrun issue
Date: Tue, 2 Jun 2009 21:52:50 +0530
Message-ID: <c0ec47240906020922r76371458r2d31a6d6f7b39a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AA40245A9
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 18:22:51 +0200 (CEST)
Received: by gxk2 with SMTP id 2so3557144gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 09:22:50 -0700 (PDT)
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

Hi,

   I'm trying to develop one application using alsa lib. The application
receives encoded sound data from a udp socket and decodes the data and write
it to device. Is it possible to set the buffer length for alsa?. In my
application i have a short array of size 6000 to keep the decoded data and
decoded data length is 5120. What period size i should set. It always set
940 frames. When i used the OSS calls, it works fine. When i used the alsa
lib it gives underrun. How can i resolve this?

Thanks,
-Renju
