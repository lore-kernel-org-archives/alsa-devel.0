From: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Subject: Re: via82xx.c, snd_via8233_dxs_volume_put change
Date: Fri, 14 Oct 2005 15:40:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510141525580.17656@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0510141244070.17656@artax.karlin.mff.cuni.cz>
 <s5hd5m81cci.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5m81cci.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 14 Oct 2005, Takashi Iwai wrote:
> Hi,
>
> some minor suggestions for the patch:
>
>> @@ -1723,12 +1766,21 @@
>>  		strcpy(sid.name, "PCM Playback Volume");
>>  		sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>>  		if (! snd_ctl_find_id(chip->card, &sid)) {
>> +			printk(KERN_WARNING "Warning: Using DXS as PCM Playback\n");
>
> It's the intended behavior, so no reason to warn the user.
>
Well, warning sound too seriously. But I think something should be there, 
it's not exactly normal behavior. Notice ? Debug ?

>> +			err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_via8233_pcmdxs_volume_control, chip));
>> +			if (err < 0)
>> +				return err;
>> +		}
>> +#ifndef EXPERIMENTALLY_USE_DXS_BOTH_AS_PCM_AND_DXS
>> +		else
>> +#endif
>
> Let's drop this "double feature" as we discussed in private mails.
>
I'm waiting on opinion of someone who have that type of codec and will 
test how bad it really is.
It's not like there will be so much users trying to enable different part 
of code ... and there already is several #if 0 and #if 1 in this file.
Hmmm ... maybe something as "#if 1 /* Using DXS when PCM emulation is 
enabled is really wierd */" will look better.

>> @@ -1939,7 +1991,7 @@
>>  		for (idx = 0; idx < 4; idx++) {
>>  			unsigned long port = chip->port + 0x10 * idx;
>>  			for (i = 0; i < 2; i++)
>> -				outb(chip->playback_volume[i], port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
>> +				outb(chip->playback_volume[idx][i]=chip->playback_volume_c[i], port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
>
> Please split to two lines, the substitution and outb.
> You don't have to save the space of source code :)
>
You have right, in this case readability overweight that few bytes of 
lost HDD space.
Should I really make that changes and repost patch, or should I wait for 
other changes ?
 	Honza
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDT7U6tYQjN8jZGdQRAkEqAKDftKmhRIbt1yawB+OMii5o4NkQGwCg2evh
qb44miWTVhS8n3CXpMU/Y84=
=wh6C
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
