From: Jacopo De Simoi <jacopods@gmail.com>
Subject: Conexant 5051 subsystem 0x103c30d6
Date: Fri, 22 Jan 2010 13:47:11 +0100
Message-ID: <201001221347.11268.jacopods@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 7419B24456
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 13:45:54 +0100 (CET)
Received: by ewy5 with SMTP id 5so1577025ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 04:45:53 -0800 (PST)
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

Dear all, 
this is a follow up to my previous posting to the ml about having CX 5051 working on my laptop;
I found out that the patch provided in
 http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024284.html
fits perfectly my model as well.
Hence I suggest to add a quirk matching my subsystem id as follows:

SND_PCI_QUIRK(0x103c, 0x30d6, "HP DV2700", CXT5051_F700)

Thanks
  __J
