From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: ENS1373 and AC3/DTS SPDIF output
Date: Wed, 07 May 2003 20:04:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EB94AC4.90503@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

The one thing the current ENS1371 driver seems to be lacking is support 
for AC3 passtrough SPDIF. At least, as far as I know. I never got it to 
work.
I currently use a "Soundblaster 4.1 digital" card based on an ENS1371 
variant (i assume the ENS1373) that, according to creative's specs, 
supports AC3 passtrough. But neither on windows (one seems to be needing 
XP for that) nor on linux I could get it to work. Plain SPDIF works 
fine, but raw-mode passtrough doesnt.

Anybody on the list that succeeded in testing this?

Should the card not support raw mode, is it possible to 'encode' the AC3 
stream in a digital 48kHz stereo stream? If I'm not mistaking, I've seen 
some ALSA drivers doing something like this... how does it work?

Thanks,

Pieter



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
