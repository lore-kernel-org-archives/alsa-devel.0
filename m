From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Thu, 25 Jul 2002 15:23:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020725222328.GA2919@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org> <20020724212315.GK1681@porky> <3D3F21CD.9090600@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3F21CD.9090600@cucumelo.org>; from gorm@cucumelo.org on Wed, Jul 24, 2002 at 14:53:17 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.07.24 14:53 Benny Sjostrand wrote:
>> MasterMixSCB:
>> 0090 00000000 00000000 00001478 00000000 0094 00000000 00000000 
>> 00000000 00000000 0098 00000080 00A00000 0000809A 000000C3 009C 
>> 14F80000 00000000 80008000 80007FFF
> The 9th Dword in SCB is the sub_list_ptr which points
> to the SCB's child SCB. Which is in this case is 00A0
> which points to the SRCTaskSCB (sample rate converter).
> When SPDIF output is muted the MasterMixSCB sub_list_ptr
> is 00A0 -> SRCTaskSCB, and when SPDIF output is unmuted
> sub_list_ptr is 0x00E0 AsynchFGTxSCB.
> In the moment of this dump the SPDIF seems to be muted.

    I can watch what you're saying as I mute and unmute "IEC 958" in
alsamixer. Muted, the 9th dword is 00a0, unmuted it's 00e0. Side question:
you referenced AsynchFGTxSCB. What's the FGT acronym stand for?)


>> 0bc0 SPDIFOSCB:
>> 00000000 000000b0 00000000 00000000 00000000 00000086 1820fffc 00000000 
>> 00000000 00000600 0bcd020f 00000040 000020ff 0000804c 00010108 deadc0ed
> First dword 0, SPDIF output inactive.

    Here's a strange one. With "IEC 958" muted, I view dsp_scb, and the
first dword of SPDIFOSCB is 00000000. I unmute "IEC 958", and I can watch
the first dword of SPDIFOSCB change each time I view dsp_scb. Here's a list
of each individual number I get (duplicates have been removed):

80005001
80001001
80000001
80002001
00001001
80003001
80006001
00006001
00003001
00004001
80003001
80004001
00000001
00007001
80005001
00005001
80007001
00002001
00005001

    I tried this with and without sounds playing (though I still can't hear
them). Do you have any information regarding what each bit stands for in
the first dword of SPDIFOSCB? (if you do, could you point me to where you
obtained this information so I can try to educate myself?)  I'm writing
this because it seems strange; I don't understand why the status bits would
keep changing for no (apparent) reason.


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
