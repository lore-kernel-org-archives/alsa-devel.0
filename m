From: Nevyan Neykov <nevyanmail@yahoo.com>
Subject: Lenovo G580 mic noise when recording
Date: Wed, 26 Mar 2014 23:21:45 -0700 (PDT)
Message-ID: <1395901305.17217.YahooMailNeo@web125103.mail.ne1.yahoo.com>
Reply-To: Nevyan Neykov <nevyanmail@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm27-vm3.bullet.mail.ne1.yahoo.com
 (nm27-vm3.bullet.mail.ne1.yahoo.com [98.138.91.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 915EB2651D3
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 07:21:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello, my lenovo g580(2189, 20150) laptop is using intel hd audio conexant driver( Intel Corporation 7 Series/C210 ) and experiencing lots of noise when trying to record from either external or internal microphone. If I lower mic volume / boost the voice get barely recorded. I am using this line in my alsa conf: options snd-hda-intel model=auto position_fix=2 also tried with model=asus etc..., when using position_fix=1 recording receives lots of cracking noise. 
I must mention that both mics are working very well under win7/8.
Regards.
