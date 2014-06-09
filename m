From: asd <asd@marian1000.go.ro>
Subject: patch_realtek. issue
Date: Mon, 09 Jun 2014 13:44:48 +0300
Message-ID: <2806822.LQTmuSTqxM@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-228-204.residential.rdsnet.ro
 [5.14.228.204]) by alsa0.perex.cz (Postfix) with ESMTP id 6DCA02615F3
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 12:44:49 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1Wtx4K-0002r7-JK
 for alsa-devel@alsa-project.org; Mon, 09 Jun 2014 13:44:48 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
Sending command to the codec from patch_realtek.c is on big mistake because 
entire structure (struct hda_codec.c) is bloched and nust be accesed via 
mutex.
