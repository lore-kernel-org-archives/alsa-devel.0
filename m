From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: support for cs46xx bass/treble control in mixer?
Date: Tue, 12 Nov 2002 01:11:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD0472A.9050002@cucumelo.org>
References: <20021111221619.NIHP24365.rwcrmhc51.attbi.com@rwcrwbc70>
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
To: jordan.breeding@attbi.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>  Will the OSS mixer implementation for the cs46xx using the new DSP code be 
>getting bass/treble controls in the mixer at some point?
>  
>
If there no HW support for that in the AC97 CODEC's you will not have 
any bass/treble
in the mixer.

However the DSP have support to add some kind of equalizer 
functionality, which is not implemented
in current driver, probably wont be, unless Cirrus provides some 
technical information
about howto do it.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
