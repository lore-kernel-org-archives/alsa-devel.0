From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Fri, 1 Aug 2014 19:07:08 +1000 (EST)
Message-ID: <61402.86.107.254.57.1406884028.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
 <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
 <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
 <CAN8cciZ_KT9HG3K3xW-X-PFvWya1zW46JXccq-jd5v6uaeTjOA@mail.gmail.com>
 <59490.86.107.254.57.1406831144.squirrel@boosthardware.com>
 <CAN8cciYrj25NfmjD86ndzJd5r=D0bMNHE55JuEKichznAkAUHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EFA72607C8
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 11:07:10 +0200 (CEST)
In-Reply-To: <CAN8cciYrj25NfmjD86ndzJd5r=D0bMNHE55JuEKichznAkAUHA@mail.gmail.com>
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


On Fri, August 1, 2014 5:19 pm, Raymond Yau wrote:
>

alsa-info:

retask and apply
http://boosthardware.com/alsa-info1.txt

store and reboot
http://boosthardware.com/alsa-info2.txt



>
> Do you mean the plugging of subwoofer cannot be detected
>
> hda-jack-sense-test -c 1 -a
>

prior to latest changes with hdajackretask:

# python alsa-jack-sense-test.py -c 1 -a
Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black HP Out): present = No
Pin 0x16 (Not connected): present = No
Pin 0x18 (Black Mic): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out): present = No
Pin 0x1f (Not connected): present = No

headset connected:

# python alsa-jack-sense-test.py -c 1 -a
Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black HP Out): present = Yes
Pin 0x16 (Not connected): present = No
Pin 0x18 (Black Mic): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out): present = No
Pin 0x1f (Not connected): present = No

after latest reboot (alsa-info2.txt):

# python alsa-jack-sense-test.py -c 1 -a
Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black HP Out): present = No
Pin 0x16 (Not connected): present = No
Pin 0x18 (Black Mic): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out): present = No
Pin 0x1f (Not connected): present = No

headset connected:

# python alsa-jack-sense-test.py -c 1 -a
Pin 0x12 (Internal Mic): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black HP Out): present = Yes
Pin 0x16 (Not connected): present = No
Pin 0x18 (Black Mic): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No
Pin 0x1b (Not connected): present = No
Pin 0x1d (Not connected): present = No
Pin 0x1e (Black SPDIF Out): present = No
Pin 0x1f (Not connected): present = No



>
> The graph don't contain enough into for debugg
>
> Post output of alsa-info.sh after retasked
>
> Seem headphone is more important than multichannel speaker when evaluating
> the badness of config
>
> You may need to configure alsa driver --with-debug=verbose to produce more
> information in system log about how it evaluate the badness
>

Easier said than done.  I have to build a custom kernel in order to get
custom alsa-drivers to build on this machine so at the moment I am stuck
with whatever I got in 3.14.1.  From the list above can you make a
recommendation for the best options to test?

According to hdajackretask the pins I can retask for output are the
following:

Pin 0x14 (Internal Speaker): present = No
Pin 0x15 (Black HP Out): present = No
Pin 0x16 (Not connected): present = No
Pin 0x18 (Black Mic): present = No
Pin 0x19 (Not connected): present = No
Pin 0x1a (Not connected): present = No


- The other pins present just a few options for input ex, mic, line in,
spdif.




--
Patrick Shirkey
Boost Hardware Ltd
