From: Swen Wenzel <swen.wenzel@t-online.de>
Subject: Disabled jacks on motherboard 'Gigabyte G1 Sniper Z87'
	(CA0132-based)
Date: Sat, 09 Aug 2014 16:55:32 +0200
Message-ID: <53E63664.5000005@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E7BA2610C5
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 16:55:45 +0200 (CEST)
Received: from fwd27.aul.t-online.de (fwd27.aul.t-online.de [172.20.26.132])
 by mailout02.t-online.de (Postfix) with SMTP id 23EC7485251
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 16:55:45 +0200 (CEST)
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

Hello guys,

I own the motherboard mentioned in the subject and experienced problems 
when I tried to get it to work.
After some conversation <http://pastebin.com/HnmxuU1Q> in IRC we found 
out, that probably the jack I used was deactivated. I had to use the 
lineout jack instead of the headphone/speaker jack.
However the headphone/speaker jack could be enabled to give the same 
output as the lineout jack with 'hda-verb'.
Here is my alsa information:
http://www.alsa-project.org/db/?f=8f57f0b72d65046469b8b6ce8a57ff6fe0371769

Maybe you can have a look at it. You can also always contact me if you 
have further questions or want me to try something out.
I am also a programmer, and studied something related to computer 
science so you don't have to fear completely useless answers or too dumb 
questions. :D

kind regards
Swen
