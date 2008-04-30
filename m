From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Problem with aloop
Date: Wed, 30 Apr 2008 17:27:37 -0300
Message-ID: <4818D639.6070008@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tet.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id AA67B2477F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 22:27:41 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 3B76EDE8448
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 17:27:40 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 3A2AADE8445
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 17:27:37 -0300 (BRST)
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

    I am developing an application that captures sound and send it 
through a network, just like a sound server. To test it I am using 
kaffeine with alsa output plugin. After some time playing continuously, 
or if I keep moving the position slider backward and forward, I get 
choppy sound. If I close and reopen the capture stream opened by my 
sound server, the sound is restored to good quality. Sometimes I have to 
reopen many times before I get a good sound. When I use kaffeine oss 
output plugin I don't have this issue. I don't have an audio sound card, 
so I don't know if this is an aloop issue.

Here are some details:
- RedHat EL 4 kernel 2.6.9.55-ELsmp 64bit
- Alsa 1.0.16
- Xinelib 1.1.12

Please, if more details are needed I will be happy to provide them.
Thanks in advance.
