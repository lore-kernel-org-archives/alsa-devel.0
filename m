From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Conversion from S16 format to ALAW
Date: Tue, 16 Nov 2004 09:28:21 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411160926111.21901@pnote.perex-int.cz>
References: <4199B349.4080404@ma.tech.ascom.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4199B349.4080404@ma.tech.ascom.ch>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Nov 2004, Manu Sharma wrote:

> Hi all,
> 
> I am trying to sample and play alaw streams on my iPAQ 5500. The HW 
> driver registers support for S16_LE only. So, to achieve my purpose, I 
> register a plugin like following in my alsa.conf file:
> 
> pcm.alaw {
> 	type alaw
> 	slave {
> 		pcm  "hw:0.0"
> 		format S16_LE
> 	}
> }
> 
> With this, when I use arecord to capture sound, I get an error "arecord: 
> set_params:832: Sample format not available".

Could you specify the full command? It should be something like:

arecord -D alaw -f A_LAW ...

Anyway, the default device should do this job for you also:

arecord -f A_LAW ...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
