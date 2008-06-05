From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: aplay works but not real player
Date: Thu, 5 Jun 2008 16:56:27 +0530
Message-ID: <827ad74d0806050426o787c34eo49432eea5abdeee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id CBC1924607
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 13:26:29 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so119296and.80
	for <alsa-devel@alsa-project.org>; Thu, 05 Jun 2008 04:26:28 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am using .copy function in my driver.
aplay playes any .wav file given. When i open real player and try playing it
says device is busy.
I tried the earlier advice to write the following into ~./asoundrc but does
not help
pcm.!default{
type hw
card 0
}

any clue that can help me ?

-- 
-Harsha
