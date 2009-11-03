From: Ketan Deshpande <ketan.deshpande@tcs.com>
Subject: Query regarding broken pipe on capturre device
Date: Tue, 3 Nov 2009 11:43:46 +0530
Message-ID: <OFF63A21C9.D910FAF4-ON65257663.0022383D-65257663.0022384D@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmumg02.tcs.com (Inmumg02.tcs.com [219.64.34.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D5C081037F8
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 07:13:58 +0100 (CET)
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


Hello All,

    I am facing a certain problem in the application development using
ALSA.Below is the small description of my problem

    I am trying to read from the capture device using "snd_pcm_readi"; but
sometimes i get a error saying "error reading from capture device : broken
pipe -32". Which results in the audio break.

    I have tried to use the port in blocking as well as non blocking mode
but that does not seem to help. I have tried to make sure the buffer sizes
match, using the below mentioned formula.

    ALSA Buffer size in my Apllication = 1024 * 8 =  Periodsize * number of
periods = HW Buffer size

    Can you please suggest me, as to what could be the reason for the
broken pipe error and how can I get rid of that?

regards,
-Ketan

=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you
