From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: xine with dmix
Date: Wed, 21 Jan 2004 23:15:23 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400F080B.3060800@superbug.demon.co.uk>
References: <1074607760.9700.453.camel@thor.asgaard.local>  <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>  <1074614789.9699.464.camel@thor.asgaard.local> <1074620372.9697.480.camel@thor.asgaard.local> <Pine.LNX.4.58.0401212012430.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401212012430.2010@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Michel Dänzer wrote:
> 
> 
>>On Tue, 2004-01-20 at 17:06, Michel Dänzer wrote:
>>
>>>On Tue, 2004-01-20 at 16:29, Jaroslav Kysela wrote:
>>>
>>>>On Tue, 20 Jan 2004, Michel Dänzer wrote:
>>>>
>>>>Could you try the attached patch? If you add a line 'slowptr yes' to your 
>>>>dmix pcm definition, the snd_pcm_delay() function should be more precise.
>>>
>>>It seems to work perfectly, thank you very much!
>>
>>I have to take that back. :(
>>
>>I had put the slowptr in the wrong place (in the dmixer slave pcm
>>block), and xine silently fell back to using /dev/dsp (alsa-oss doesn't
>>seem to work with it). With the slowptr in the right place, I have now
>>verified that xine uses ALSA with it enabled, but it doesn't seem to
>>enhance sound quality much if at all.
>>
>>Sorry for the false confirmation. Any other ideas?
> 
> 
> Yes, I've tested xine with dmix today and I figured after several hours of 
> looking for totaly another problem, that it was 'snd_pcm_wait()' function 
> which causes trouble in conjunction with the xine ALSA code algorithm.
> 
> The result patch (attached to this mail and available also in CVS) is that
> xine works with dmix even without the slowptr option! So there is no 
> reason to make this option as default.
> 
> I'm happy that the next direct plugin related bug is solved.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 

Thank you very much for your efforts to help xine work with alsa.

So, the problem was a bug in alsa?
As you have obviously looked very hard now at the xine code, would you 
have any recommendations for any changes?

Cheers
James




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
