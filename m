From: Graham Stoney <greyhams@optusnet.com.au>
Subject: Problems building latest cvs snapshot
Date: Sun, 11 Aug 2002 12:52:40 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020811025240.GB4844@optusnet.com.au>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi gang,

I had problems compiling alsa-driver-0.9.0rc2: multiple definitions of
__module_kernel_version & __module_using_checksums linking snd-emu8000-synth.
So I thought I'd try building the latest cvs snapshot, to see if the problem
has been fixed before I waste people's time reporting it. Ran into trouble
though:

I did:
% cvs -... co alsa-driver alsa-kernel alsa-lib alsa-tools alsa-utils
% cd alsa-driver
% autoconf
% ./configure
...
./configure: ALSA_TOPLEVEL_INIT: command not found
./configure: ALSA_TOPLEVEL_SELECT: command not found
...

Anyone know what might be going on here?

Is there a "getting started" document for ALSA developers?

Thanks,
Graham


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
