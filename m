From: Manu Sharma <manu.sharma@ma.tech.ascom.ch>
Subject: Re: Conversion from S16 format to ALAW
Date: Tue, 16 Nov 2004 17:32:17 +0100
Message-ID: <419A2B91.8070803@ma.tech.ascom.ch>
References: <4199B349.4080404@ma.tech.ascom.ch> <Pine.LNX.4.58.0411160926111.21901@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411160926111.21901@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks Jaroslav and Takashi for your questions; they served as inputs !

I was not explicitly specifying the format (-f A_LAW), considering that 
since the plugin type itself is "alaw". I missed the fact that I 
specified default format of this plugin to be S16_LE in my alsa.conf !

I have another question about the warning given in function header of 
snd_pcm_alaw_open (same applies for corresponding mulaw function).

Does the warning suggest that applications should not be using this 
function directly, they should instead configure their alsa.conf and use 
snd_pcm_open ?

Manu

Jaroslav Kysela wrote:
> On Tue, 16 Nov 2004, Manu Sharma wrote:
> 
> 
>>Hi all,
>>
>>I am trying to sample and play alaw streams on my iPAQ 5500. The HW 
>>driver registers support for S16_LE only. So, to achieve my purpose, I 
>>register a plugin like following in my alsa.conf file:
>>
>>pcm.alaw {
>>	type alaw
>>	slave {
>>		pcm  "hw:0.0"
>>		format S16_LE
>>	}
>>}
>>
>>With this, when I use arecord to capture sound, I get an error "arecord: 
>>set_params:832: Sample format not available".
> 
> 
> Could you specify the full command? It should be something like:
> 
> arecord -D alaw -f A_LAW ...
> 
> Anyway, the default device should do this job for you also:
> 
> arecord -f A_LAW ...
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
