From: Aurelien Bouin <a_bouin@yahoo.fr>
Subject: Device Tree simple-audio-card without codec HOWTO ?
Date: Thu, 18 Dec 2014 09:55:30 +0000 (UTC)
Message-ID: <2137743326.101731.1418896530601.JavaMail.yahoo@jws11132.mail.ir2.yahoo.com>
Reply-To: Aurelien Bouin <a_bouin@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm19.bullet.mail.ir2.yahoo.com (nm19.bullet.mail.ir2.yahoo.com
 [212.82.96.42]) by alsa0.perex.cz (Postfix) with ESMTP id 8957A261685
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 10:55:32 +0100 (CET)
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

Hello,

I use the iMX6 ESAI bus to send audio datas to other processors ... but actually I don't have any codec behind ...
I am wondering if there is any solution with the devicetree to implement such configuration with "simple-audio-card"
That will configure tdm slots and width.
I tried without success that :
sound {
    compatible = "simple-audio-card";
    simple-audio-card,name = "Generic-ESAI-Sound-Card";
    simple-audio-card,format = "left_j";
    simple-audio-card,cpu {
        sound-dai = <&esai 0>;
        dai-tdm-slot-num = <32>;
        dai-tdm-slot-width = <8>;
    };
    simple-audio-card,codec {
        sound-dai = <0 0>;
    };
};

Because for the moment I have not find another solution than doing a module : http://pastebin.com/cnGwnEjn
Thank you for your help,
Regards,

Aurelien BOUIN
