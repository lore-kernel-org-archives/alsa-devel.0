From: Frank Barknecht <fbar@footils.org>
Subject: ALSA vs OSS: Some questions
Date: Mon, 7 Apr 2003 16:50:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030407145029.GA19610@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,

I'm working on a Linux Audio article, where I also do provide a short
comparison of ALSA vs. OSS. For this, because I'm in no way a hardware
developer, I have some questions to make sure, I understand things
correctly. Would someone with deeper insight in the OSS/ALSA internals
help me and tell me, if the following assumptions are correct?

I read, that OSS was hard to extent, for example to write drivers for
modern hardware. Why is this so? 

Is it, because OSS ties its model of programming too close to the
hardware?

Paul Davis said in its LAD keynot, that in the past we only had OSS
and only had 16-bit interleaved stereo. From reading the OSS-developer
docs, it seemed to me, that OSS does support more formats than 16-bit
interl. stereo. So what can ALSA do in the format department, that OSS
couldn't do?

Can the ICE1712 chip server as an example for these difficulties? The
ICE chip doesn't support CD-quality music (44.1 samplerate, 16-bit,
stereo) in hardware, if I'm right? What format does it support? And
how does ALSA help in getting this supported compared to OSS (which
hasn't support for the ICE-cards)

Thank you very much for your answers and facts.

Regards,
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
