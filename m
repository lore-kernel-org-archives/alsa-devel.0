From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy DSP questions.
Date: Sun, 18 Sep 2005 19:00:33 +0100
Message-ID: <432DAB41.9070508@superbug.co.uk>
References: <432D8AA7.4040203@superbug.co.uk> <432DA3D7.2070904@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432DA3D7.2070904@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> James Courtier-Dutton wrote:
> 
>> In emufx.c there is the following table. Can anyone tell me how to 
>> convert these values to floating point db gain values?
>> I need to know how to convert values in the DSP to values in the range 
>> +2.0 to -2.0
>>
>> static const u32 db_table[101] = {
>>         0x00000000, 0x01571f82, 0x01674b41, 0x01783a1b, 0x0189f540,
>>         0x019c8651, 0x01aff763, 0x01c45306, 0x01d9a446, 0x01eff6b8,
>>         0x0207567a, 0x021fd03d, 0x0239714c, 0x02544792, 0x027061a1,
>>         0x028dcebb, 0x02ac9edc, 0x02cce2bf, 0x02eeabe8, 0x03120cb0,
>>         0x0337184e, 0x035de2df, 0x03868173, 0x03b10a18, 0x03dd93e9,
>>         0x040c3713, 0x043d0cea, 0x04702ff3, 0x04a5bbf2, 0x04ddcdfb,
>>         0x0518847f, 0x0555ff62, 0x05966005, 0x05d9c95d, 0x06206005,
>>         0x066a4a52, 0x06b7b067, 0x0708bc4c, 0x075d9a01, 0x07b6779d,
>>         0x08138561, 0x0874f5d5, 0x08dafde1, 0x0945d4ed, 0x09b5b4fd,
>>         0x0a2adad1, 0x0aa58605, 0x0b25f936, 0x0bac7a24, 0x0c3951d8,
>>         0x0ccccccc, 0x0d673b17, 0x0e08f093, 0x0eb24510, 0x0f639481,
>>         0x101d3f2d, 0x10dfa9e6, 0x11ab3e3f, 0x12806ac3, 0x135fa333,
>>         0x144960c5, 0x153e2266, 0x163e6cfe, 0x174acbb7, 0x1863d04d,
>>         0x198a1357, 0x1abe349f, 0x1c00db77, 0x1d52b712, 0x1eb47ee6,
>>         0x2026f30f, 0x21aadcb6, 0x23410e7e, 0x24ea64f9, 0x26a7c71d,
>>         0x287a26c4, 0x2a62812c, 0x2c61df84, 0x2e795779, 0x30aa0bcf,
>>         0x32f52cfe, 0x355bf9d8, 0x37dfc033, 0x3a81dda4, 0x3d43c038,
>>         0x4026e73c, 0x432ce40f, 0x46575af8, 0x49a8040f, 0x4d20ac2a,
>>         0x50c335d3, 0x54919a57, 0x588dead1, 0x5cba514a, 0x611911ea,
>>         0x65ac8c2f, 0x6a773c39, 0x6f7bbc23, 0x74bcc56c, 0x7a3d3272,
>>         0x7fffffff,
>> };
>>
>>
> 
> I think I have worked it out.
> Take each value and divide by 0x80000000 to get a value between 0 and 1.
> This is then converted into dB with
> 0 == Mute
> 0x01571f82 == -19.8 dB
> 0x7fffffff == 0 dB
> With each value being a constant step of 0.2 dB.
> 
> James
> 
> 
Did anyone spot the deliberate mistake?



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
