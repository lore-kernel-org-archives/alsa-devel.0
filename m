From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: A debug version of the ALSA lib?
Date: Thu, 01 Sep 2011 10:37:39 +0200
Message-ID: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B1B24759
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 10:38:00 +0200 (CEST)
Content-description: Mail message body
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

I have a problem with the ALSA library. Calling snd_device_name_hint() crashes 
sometimes, and I can't understand why.

It might be due to a previous memory corruption in my program, a problem with 
my sound card driver, or a bug in the library, I don't know.

I tried to debug it in assembler, and found that the library is browsing a list 
of devices, gets the pointer to each device name, and in the 2nd device, I get 
the four letters "Play" instead of a valid pointer.

To be able to go further, I'd need a debug version of the ALSA library, 
including variable names and source lines, which could let me find more easily 
what goes wrong and when.

Is it possible to build such a library from the alsa-lib-1.0.24.1 sources? 
Or should I download and install another specific package?

Thank you,
Olivier
