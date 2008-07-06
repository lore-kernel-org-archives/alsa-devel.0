From: "Constrabus Gegami" <constrabus@gmail.com>
Subject: HDA Intel ALC885 - Need new or edited model option
Date: Sun, 6 Jul 2008 11:26:52 -0400
Message-ID: <b09778df0807060826m1b816cf2s8dbe0751fc2a4fd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A016244FD
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 17:26:53 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so328513and.80
	for <alsa-devel@alsa-project.org>; Sun, 06 Jul 2008 08:26:52 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I need a new or edited model option for this card:
HDA Intel card in Alienware m15x laptop

That uses codec:
ALC885

Detailed specifications on the card:
http://www.alienware.com/Configurator_Pages/Details_Pages/Details_Page.aspx?CatId=1421&ItemId=16514&ItemIdList=16515

alsa-info.sh genterated output:
http://pastebin.ca/1061774
(i switched back to no model options before i ran the script, i dont know
  if it leaves behind anything or if it even matters)

Jack Observations:
-1x auto-sensing headphone jack
-1x auto-sensing microphone jack


All current available model options either present me with:
-working switchable internal speakers with non working headphone jack
-working switchable headphone jack with non working internal speakers
-non working headphone jack and internal speakers
-working non switchable internal speakers with non working heaphone
-working non switchable headphones with non working speakers
-no working sound

What is needed:
- working switchable internal speakers with working headphone and mic jack
(preferably switchable)


Distro: Gentoo amd64 using alsa driver package (not in kernel modules)

I hope that this will benefit others as well as I.
If any more information is needed, please email me.

-- 
--Constrabus
