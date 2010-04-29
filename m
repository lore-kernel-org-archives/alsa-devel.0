From: Yu Hang <hangy@fortemedia.com.cn>
Subject: How to retrieve the final data being played by HW
Date: Thu, 29 Apr 2010 17:15:38 +0800
Message-ID: <4BD94E3A.2040301@fortemedia.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxvip36.hichina.com (mxvip36.hichina.com [218.106.248.86])
	by alsa0.perex.cz (Postfix) with ESMTP id EBB362441D
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 11:15:39 +0200 (CEST)
Received: from 58.240.78.110 (HELO ?127.0.0.1?) (envelope-from
	hangy@fortemedia.com.cn)
	by mxvip36.hichina.com (quarkmail-1.2.1) with ESMTP id S4192864Ab0D2JPe
	for alsa-devel@alsa-project.org; Thu, 29 Apr 2010 17:15:34 +0800
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

I'm studying ALSA lib and trying to write a plugin that can perform AEC 
function. I have to retrieve the data being played and use it as reference.
I've read pcm_dmix.c and found dmix just simply mixes data into HW mmap 
buffer (destination buffer). My problem is, there might be several dmix 
instances, which doesn't know if there is other dmix instance. So how 
can I know the mixed data is exactly the data being played.
For example, the 1st instance had mixes the data into destination 
buffer, but 2nd instance haven't complete the mix operation. Would the 
data in destination buffer be playing by HW?
Or there is some mechanism to guarantee the data will be played after 
all mix operation is done.
