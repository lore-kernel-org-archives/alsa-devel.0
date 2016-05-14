From: Petr Kulhavy <brain@jikos.cz>
Subject: TAS571x input mixer
Date: Sat, 14 May 2016 14:18:34 +0200
Message-ID: <77f93aa3-a627-4e84-71b2-71037c71633e@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep25.mx.upcmail.net (fep25.mx.upcmail.net [62.179.121.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5902A260542
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 14:18:36 +0200 (CEST)
Received: from edge02.upcmail.net ([192.168.13.237]) by viefep25-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160514121836.NOFN1507.viefep25-int.chello.at@edge02.upcmail.net>
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 14:18:36 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm implementing input mixer controls for the TAS571x amplifier driver.
The mixer register values are signed 3.23 fixed-point linear 
coefficients (i.e. numbers between -8.0 and +7.999), where the default 
value is 1.0

I would like to represent them as ALSA controls and have a few questions:

* The mixing coefficients are signed, i.e. using negative values can 
invert the signal polarity. Does it make sense to allow negative values 
at all?

* Does it make sense to allow values >1.0 i.e. allow digital 
amplification of the signal?

* What is the usual way of representing linear mixer coefficients in 
ALSA (most of the codecs use dB though)? Shall I try to convert them to 
dB? Are there such functions in ALSA?

Thanks
Petr
