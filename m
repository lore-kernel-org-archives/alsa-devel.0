From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: [PATCH] aureon.c - adc mux, master vol
Date: Tue, 06 Jul 2004 21:05:44 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EB4C68.2090804@aei.ca>
References: <40E6D4D0.6000206@gmx.at> <s5h4qom93jx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qom93jx.wl@alsa2.suse.de>
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


I think it would be convenient for the end user  to keep the Master
volume attenuation on Aureon & Prodigy.  There are seperate analog and
digital volume controls on the chip and since each DAC has it's analog
volume control as a mixer element, why not have the master digital
volume as another control?

Minor change one could say but imagine someone trying to adjust the
volume of his 5.1 speaker system while playing a DVD.

Apostolos


Takashi Iwai wrote:

>Thanks for the patch.  Looks like I forgot to remove/change some
>things.  It would be nice if you can test aureon boards with the
>latest changes.
>
>The below is the completely rewritten patch.  It includes
>
>- Removal of 'Master Playback Volume', which is bogus
>  (it forces to change all DAC volumes)
>
>- Split 'DAC Volumes' to Front/Rear/Center/LFE/Side volumes.
>  Please test whether the volume element really corresponds to the
>  assigned output.  Rear and Center/LFE might be swapped.
>- Fix ADC capture mutx for stereo.
>
>
>thanks,
>
>Takashi
>  
>




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
