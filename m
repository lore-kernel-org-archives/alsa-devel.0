From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp vs 16bit vs dmix
Date: Mon, 26 Jan 2004 15:10:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40151FEB.6040409@undata.org>
References: <3FFC41E9.3050501@boosthardware.com> <s5hn08yznzf.wl@alsa2.suse.de> <40150EB7.8070907@undata.org> <Pine.LNX.4.58.0401261415070.2959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401261415070.2959@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote :
> On Mon, 26 Jan 2004, Thomas Charbonnel wrote:
> 
> 
>>Now if you do specify 'channels 18' in the dmix slave definition, the 
>>error is as follows :
>>aplay: set_params:827: Sample format non available
>>I have 'format S32_LE' set in the dmix slave definition, but it doesn't 
>>seem to be taken into account.
> 
> 
> It should be. Did you used 'aplay -D plug:your_dmix'?
> 
> 						Jaroslav
> 

You're right, I only used '-D my_dmix'.
Using '-D plug:my_dmix' works properly, so I guess the problem is 
solved, thanks !

For the record here's the working .asoundrc section :

pcm.hdsp_dmix {
     type dmix
     ipc_key 1024
     slave {
         pcm {
             type hw
             card 2
         }
         rate 44100
         format S32_LE
         channels 18
     }
}

Of course people will have to tweak the card and channels number to 
match their setup.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
