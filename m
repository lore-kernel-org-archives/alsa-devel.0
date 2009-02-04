From: Hartman Mario Andres <hartmanmario@gmail.com>
Subject: driver or plugin?
Date: Wed, 04 Feb 2009 17:55:12 -0200
Message-ID: <4989F2A0.7020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB7C1037ED
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 20:55:20 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c5so1309591anc.2
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 11:55:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

hi everybody, this is my first post in the list.

currently i work in a new project, and i need is some help to finish
this. I wrote an application whose take data from serial port or from
bluetooth device(spp) and store the data in a raw file(the data is
audio). Now i need to do this: the data received from the port, send
to internet through voip software like ekiga, kphone, etc.
I read  writing-an-alsa-driver.pdf, alsa-driver-api.pdf but i dont
know how create a source of data, for softwares of voip take data like
a microphone and also receive data from these programs.
I've been looking serial-u16550.c
   
would be something similar to what the bluez bluetooth headphones

Sorry for my english is not very good.

greetings
