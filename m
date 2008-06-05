From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Impact of SW on USB Audio?
Date: Thu, 05 Jun 2008 16:11:49 +0200
Message-ID: <4847F425.7040402@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 4908924633
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:12:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by server.insite.cz (Postfix) with ESMTP id 1F667228A46A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:12:11 +0200 (CEST)
Received: from server.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHOcdqnFlWl2 for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:12:00 +0200 (CEST)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	by server.insite.cz (Postfix) with ESMTP id 05880228A46E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:11:49 +0200 (CEST)
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

Please excuse my non-devel question but the most knowledgeable people
read this mailing list.

Can user-space software (regular players) directly influence quality of
USB adaptive audio output? IOW, how sensitive is adaptive USB to the
rhythm of the data infeed to the USB controller?

I understand for standard PCI soundcards it is all only about timely
delivery of enough data to DMA memory,the card takes care of the rest
itself. Do USB controllers shield applications from the rest in the same
manner?

The adaptive mode is sensitive to jitter of the data stream from the USB 
controller to the receiver. Can SW players influence the jitter, e.g. by 
moving the wav files from HDD to RAM disk etc.?  I assume a lightly 
loaded system with no major data delays.

Thanks a lot for any insight, I could not google-out any relevant
information.


Regards,

Pavel.
