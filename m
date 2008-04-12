From: Taek Joo Kim <taicki@gmail.com>
Subject: External IO plugin question
Date: Fri, 11 Apr 2008 20:06:18 -0400
Message-ID: <12E68E34-BB10-4E42-B05D-657092C305E1@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id D167F2459A
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 02:06:22 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so185934ana.80
	for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2008 17:06:20 -0700 (PDT)
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

Hi. I am working on ALSA external IO plugin now. Its function is  
similar to the pulse plugin. A server sends sound to multiple clients.

When I play sound with my plugin, the sound is played really fast. It  
means that it is like playing with x5 or x10 speed. I did not write  
any code for synchronization between server and client. To try to fix  
it, I saw the pulse plugin. I guess that it uses some synchronization  
code (poll_descriptors), but I am not sure.

My questions are:
1. Which part should take care of playing sound properly in this  
architecture, server or client?
2. Do I need to deal with synchronization between server and client?
3. If 2 is yes, is there any hints to do this with multiple clients?

Thank you in advance.
