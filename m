From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Thu, 10 Apr 2003 12:21:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E9553C2.3000100@superbug.demon.co.uk>
References: <20030408140230.GA1987@ulima.unil.ch>	<E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net>	<s5hn0j1q97r.wl@alsa2.suse.de>	<3E934193.6090605@cucumelo.org>	<20030408205515.GB6940@ulima.unil.ch>	<3E933EF6.5030601@superbug.demon.co.uk>	<3E93C4CA.4080604@cucumelo.org>	<20030409082815.GA14489@ulima.unil.ch>	<s5h65poq65j.wl@alsa2.suse.de>	<20030409114312.GE14489@ulima.unil.ch> <s5h4r57rf1m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r57rf1m.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gregoire,
You say that in windows SPDIF works fine and you get the AC3 decoded by 
your external decoder.
Does the decoder have any indicators telling you whether it is an AC3 of 
PCM stream ?

So, in linux, when playing a DVD in PASSTHRU mode in xine, does your 
decoder think it is AC3 or PCM ?

If the decoder still thinks it is PCM, then the problem is a bug in the 
alsa-driver, and not the application or sample rate.
If the decoder thinks it is AC3, then we can look at different problems, 
like hardware-resamplers in the way.

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
