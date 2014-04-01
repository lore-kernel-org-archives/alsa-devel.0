From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: pulseaudio and rcar-h2 sound
Date: Tue, 01 Apr 2014 15:28:45 +0100
Message-ID: <533ACD1D.9080209@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (unknown [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 8669D265452
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 16:28:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id DC27D463D72
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 15:28:47 +0100 (BST)
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
 by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1E1iFGHrBJme for <alsa-devel@alsa-project.org>;
 Tue,  1 Apr 2014 15:28:45 +0100 (BST)
Received: from [10.24.1.133] (rainbowdash.dyn.ducie.codethink.co.uk
 [10.24.1.133])
 by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 9A17646221C
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 15:28:45 +0100 (BST)
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

I am currently investigating an issue with the rcar-h2 audio driver
and a hang when running pulse-audio. From what I can see the issue
seems to be an interaction with the driver and the regmap code.

The current issue is that whatever is happening causes CPU0 to
stall, thus nothing seems to be able to continue. The following
errors are detected by the rcu code:

INFO: rcu_sched self-detected stall on CPU
         0: (1 GPs behind) idle=415/2/0 softirq=3076/3077
          (t=10500 jiffies g=520 c=519 q=51)


I have been through the regmap code and the locking looks ok. I also
enabled as much of the locking checks as I could and it does not
produce any useful output as to why it would be deadlocking.

I can run the system fine if I replace the rsnd_read, rsnd_write
and rsnd_bset code with versions which do not directly use regmap.

Does anyone have any experience with this, or any further ideas on
how to continue debugging?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
