From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: RE: PCM frames already played
Date: Sun, 17 Feb 2002 15:45:49 +0100 (MET)
Message-ID: <XFMail.020217154549.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <NGBBLNODKDFPBFMBBFAFIEPJCAAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you very much. This sounds reasonably. I will try it.
Until now I hoped there would be a more easy solution.
But this is ok.

rds guenther

On 17-Feb-02 James Courtier-Dutton wrote:
> I do this by counting how many frames have already been written(from the
> app), minus the frames still waiting to be written (from alsa, i.e. How many
> frames are still in the sound cards buffer waiting to be output.)
> 
> Cheers
> James
> 
> 
>> -----Original Message-----
>> From: alsa-devel-admin@lists.sourceforge.net
>> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Guenther
>> Sohler
>> Sent: 17 February 2002 10:28
>> To: alsa-devel@lists.sourceforge.net
>> Subject: [Alsa-devel] PCM frames already played
>>
>>
>> Is there a way to determine the number of bytes/frames already
>> played through
>> the DAC since last reset via snd_pcm_status in v0.9.x ?
>>
>> Its possible in OSS via ioctl and in alsa v0.5.0 you can view at a element
>> "bytes" in sthe respective structure.
>>
>> But how does it work in v0.9.x ?
>>
>>
>> rds guenther
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

Guenther Sohler

NewLogic Technologies AG 
Millennium Park 6
A-6890 Lustenau
                                           Phone: +43-5577-62000-507
E-Mail: guenther.sohler@newlogic.com       Fax:   +43-5577-62000-988


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
