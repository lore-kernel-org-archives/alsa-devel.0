From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Wed, 09 Apr 2003 23:17:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E948DEC.2000103@cucumelo.org>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org> <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk> <3E93C4CA.4080604@cucumelo.org> <20030409082815.GA14489@ulima.unil.ch>
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
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>>All tests I've done with xine it always output the AC3 data on 48khz, 
>>which should work fine.
>>    
>>
>
>Well, maybe with your receiver you are lucky... we have seen those days
>in this ml quiete a few people for which it doesn't work with there
>receivers.
>And as for me it works under windows, I think there is a problem in the
>software.
>  
>
What I meant, if you want to output AC3 on other sample rate's than 
48khz it wont with the current cs46xx driver (44.1 khz AC3 wont work).

The cs46xx driver can improved in many ways, I'm trying to the best and 
work on that. (whenever I got time)

It does not surprise me that it works under Windows, there may be many 
feutures that works under windows, but not under Linux.

Maybe the Windows driver supports AC3 with other sample rates then 48khz 
(if that's the case) or maybe there's another problem.

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
