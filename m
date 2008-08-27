From: "John L. Utz III" <john.utz@dmx.com>
Subject: modifying VIA8237.conf - does it currently work
 correctly for somebody?
Date: Wed, 27 Aug 2008 15:23:10 -0700
Message-ID: <op.ugkggwx9647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C59324821
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 00:23:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi;

I am sorry for the vagueness of the questions, but now that i have some  
understanding of how these files are supposed to work i want to get this  
right!

to support 4.0/5.1/7.1 for the vt1618 codec i have to change a different  
set of twiddlers than what is called out in the current version of the  
conf file.

worse yet, the twiddlers called out in the current file dont even *exist*  
on the vt1618:

   {
   	name "Surround Down Mix"
         preserve true
         value off
         lock true
         optional true
   }
   {
         name "Center/LFE Down Mix"
         preserve true
         value off
         lock true
         optional true
   }


How do i add new stuff without breaking old stuff? is there a sub-identity  
that i could use?

tnx!

johnu
