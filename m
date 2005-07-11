From: Brian Black <BlackBsd@Mountain.net>
Subject: snd_pcm_writei()  help!
Date: Mon, 11 Jul 2005 17:08:02 -0400
Message-ID: <42D2DFB2.9060203@Mountain.net>
Reply-To: BlackBsd@Mountain.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030104080708010807060008"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------030104080708010807060008
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,
	i had a question about writing to the device.  i have looked at alot of
source code for writing to the device, and i am not sure where my error
is, maybe someone might know my issue.

	i have a wave object that can read wave data into a char buffer.
i am trying to take this buffer, which i am trying to make an arbitrary
size, and write it to the device. ( i want to split the wave file up
into peices and write the peices out).

	Sometimes i pass in a size to write and i am getting an error -22
(Invalid argument) and sometimes the data writes out correctly.

	If the size i use to write to the card is say 940 and my total size i
am trying to write is 1327, it writes out the 940 correctly then the 387
correctly. Then my AlsaPlay function returns to get more wave data.
After getting the new data, it enters the alsaPlay function again, and
will try to write out the 940 and an error -22 occurs (invalid
argument).  then the next write 387 is successfull.

The sound sounds correct, but the errors are making me wonder, because i
cannot pick an arbitrary size of data to write to the device with out
the sound becomming distorted on some sounds.

i am attaching my files in case anyone might be able to point out my
errors, as i am kinda new and am stuck.

for testing i am using a mono 16bit sound file.

thanx in advance.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFC0t+xI9Y/1VIS+jgRAgeXAJ4s2oACmtvM4tB5NPDZAn4SW5wOWgCdF0BX
aLnrSzIy6AggxF3Bmx0f+H4=
=d0BC
-----END PGP SIGNATURE-----

--------------030104080708010807060008
Content-Type: text/plain;
 name="AlsaPCM.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AlsaPCM.c"

/*Alsa PCM Output File used*/

/* Use the newer ALSA API */
#define ALSA_PCM_NEW_HW_PARAMS_API

#include <alsa/asoundlib.h>

//#include "WaveReader.h"

/*Handle for the PCM device*/
snd_pcm_t *PCM_Handle;

/*Value representing the return code of the alsa call.*/
int AlsaCallReturnCode=0;

/* Sample rate */
unsigned int SampleRate=44100;
	
/* Sample rate returned by
 * snd_pcm_hw_params_set_rate_near */
unsigned int ExactRate=44100;

/* Treshold values.*/
snd_pcm_uframes_t StartThreshold=0;
snd_pcm_uframes_t StopThreshold=0;

//Size of the transfer align
snd_pcm_uframes_t XferAlign=0;

//Minimum Sleep time.
unsigned int MinSleepTime=0;

/* This parameter controls the wakeup point. If the count of
 * available samples is equal or greater than this value,
 * then application will be activated.*/
int AvailableMinSampleCount=-1;

int StartDelay=0;
int StopDelay=0;

//Period/Chunck Global Information
unsigned int PeriodTime=0;
snd_pcm_uframes_t PeriodSize=0;

snd_pcm_uframes_t FramesPerPeriod=0;
size_t SamplesPerPeriod=0;

size_t PeriodBytes=0;


//Buffer Global Information
unsigned int BufferTime=0;
snd_pcm_uframes_t BufferSize=0;

snd_pcm_uframes_t FramesPerBuffer=0;


size_t BitsPerSample=0;
size_t BitsPerFrame=0;

size_t SamplesPerFrame=0;

#define BITS_PER_BYTE	8
unsigned int NumberOfChannels=1;


int
AlsaConfigure(){

	/* For this example, we assume that the soundcard can be configured for
	 * stereo playback of 16 Bit Little Endian data, sampled at 44100 Hz.
	 * Accordingly, we restrict the configurations space to match this
	 * configuration:*/

	/*Temp Variables used.*/
	size_t n;
	
	/* ExactRate == SampleRate --> Direction = 0
	 * ExactRate < SampleRate --> Direction = -1
	 * ExactRate > SampleRate --> Direction = 1 */	
//	int Direction;
		
	/* Number of periods */
//	int Periods = 2;
	

	/* To write a simple PCM application for ALSA 0.9.0 we first
	 * need a handle for the PCM device. Then we have to specify
	 * the direction of the PCM stream, which can be either playback
	 * or capture. We also have to provide some information about the
	 * configuration we would like to use, like buffer size, sample rate,
	 * pcm data format. So, first we declare:*/

	/*Playback stream*/
	snd_pcm_stream_t Stream_Type = SND_PCM_STREAM_PLAYBACK;
	
	/* This structure contains information about the hardware
	 * and can be used to specify the configuration to be used
	 * for the PCM stream.*/ 
	snd_pcm_hw_params_t *HW_Params;
	
	/* Ditto for the software parameters.*/
	snd_pcm_sw_params_t *SW_Params;

	/* The most important ALSA interfaces to the PCM devices are the "plughw"
	 * and the "hw" interface. If you use the "plughw" interface, you need not
	 * care much about the sound hardware. If your soundcard does not support
	 * the sample rate or sample format you specify, your data will be
	 * automatically converted.  This also applies to the access type and the
	 * number of channels. With the "hw" interface, you have to check whether
	 * your hardware supports the configuration you would like to use.*/

	/* Name of the PCM device, like plughw:0,0
	 * The first number is the number of the soundcard,
	 * the second number is the number of the device.*/
	char *PCM_Name;

	/* Init pcm_name. Of course, later you
	 * will make this configurable ;-)*/
	PCM_Name = strdup("default");//"plughw:0,0");

	/* Open PCM.  The last parameter of this function is the mode.
	 * If this is set to 0, the standard mode is used. Possible
	 * other values are SND_PCM_NONBLOCK and SND_PCM_ASYNC.
	 * If SND_PCM_NONBLOCK is used, read / write access to the
	 * PCM device will return immediately. If SND_PCM_ASYNC is
	 * specified, SIGIO will be emitted whenever a period has
	 * been completely processed by the soundcard.*/
	if((AlsaCallReturnCode = snd_pcm_open(&PCM_Handle, PCM_Name, Stream_Type, 0)) < 0){
		fprintf(stderr, "Error opening PCM device %s\n", snd_strerror(AlsaCallReturnCode));
		return(-1);
	}
	
	/* Allocate the hardware parameters object structure on the stack. */
	snd_pcm_hw_params_alloca(&HW_Params);

	/* Allocate the software parameters object structure on the stack. */
	snd_pcm_sw_params_alloca(&SW_Params);

	/* Before we can write PCM data to the soundcard, we have to specify access
	 * type, sample format, sample rate, number of channels, number of periods
	 * and period size. First, we initialize the hwparams structure with the
	 * full configuration space of the soundcard. */

	/* Init HW_Params with full configuration space. */
	if((AlsaCallReturnCode = snd_pcm_hw_params_any(PCM_Handle, HW_Params)) < 0){
		fprintf(stderr, "Can not configure this PCM device: %s\n",
			snd_strerror(AlsaCallReturnCode) );
		return(-1);
	}

	/* Information about possible configurations can be obtained with a set of
	 * functions named:
	 * 		snd_pcm_hw_params_can_<capability>
	 * 		snd_pcm_hw_params_is_<property>
	 * 		snd_pcm_hw_params_get_<parameter>
	 * The availability of the most important parameters, namely access type,
	 * buffer size, number of channels, sample format, sample rate, and
	 * number of periods, can be tested with a set of functions named
	 * 		snd_pcm_hw_params_test_<parameter>
	 * These query functions are especially important, if the "hw" interface is
	 * used. The configuration space can be restricted to a certain
	 * configuration with a set of functions named:
	 * 		snd_pcm_hw_params_set_<parameter>
	 */


	/* The access type specifies the way, multichannel data is stored in the
	 * buffer. For INTERLEAVED access, each frame in the buffer contains the
	 * consecutive sample data for the channels. For 16 Bit stereo data, this
	 * means that the buffer contains alternating words of sample data for the
	 * left and right channel. For NONINTERLEAVED access, each period contains
	 * first all sample data for the first channel followed by the sample data
	 * for the second channel and so on. */

	/* Set access type. This can be either SND_PCM_ACCESS_RW_INTERLEAVED or
	 * SND_PCM_ACCESS_RW_NONINTERLEAVED.  There are also access types for
	 * MMAPed access, but this is beyond the scope of this introduction.*/
	if((AlsaCallReturnCode = snd_pcm_hw_params_set_access(PCM_Handle, HW_Params,
		SND_PCM_ACCESS_RW_INTERLEAVED)) < 0)
	{
		fprintf(stderr, "Error setting access type: %s.\n", snd_strerror(AlsaCallReturnCode));
		return(-1);
	}

	/* Set sample format, Signed 16-bit little-endian format */
	if((AlsaCallReturnCode = snd_pcm_hw_params_set_format(PCM_Handle,
		HW_Params, SND_PCM_FORMAT_S16_LE)) < 0)
	{
		fprintf(stderr, "Error setting sample format: %s\n", snd_strerror(AlsaCallReturnCode));
		return(-1);
	}

	/* Set number of channels, 2 channels (Stereo) */
	if((AlsaCallReturnCode = snd_pcm_hw_params_set_channels(PCM_Handle,
		HW_Params, NumberOfChannels)) < 0)
	{
		fprintf(stderr, "Error setting number of channels: %s.\n",
			snd_strerror(AlsaCallReturnCode));
		return(-1);
	}

	/* Set sample rate. If the exact rate is not supported
	 * by the hardware, use nearest possible rate.
	 * 44100 bits/second sampling rate (CD quality)*/
	if((AlsaCallReturnCode = snd_pcm_hw_params_set_rate_near(PCM_Handle,
		HW_Params, &ExactRate, 0)) < 0)
	{
		fprintf(stderr, "Error setting sample rate: %s.\n", snd_strerror(AlsaCallReturnCode));
		return(-1);
	}

	if(SampleRate != ExactRate){
		fprintf(stderr, "The rate %d Hz is not supported by your hardware.\n"
			" ==> Using %d Hz instead.\n", SampleRate, ExactRate);
	}


	/* Now the following few lines will be used to determine
	 * the period information and the buffer information.*/

	//lets get the buffer max buffer time
	if((AlsaCallReturnCode = snd_pcm_hw_params_get_buffer_time_max(HW_Params,
		&BufferTime, 0)) < 0)
	{
		fprintf(stderr, "Error getting max buffer time: %s.\n",
			snd_strerror(AlsaCallReturnCode));
		return(-1);
	}else{
		fprintf(stderr, "Max buffer time is: %d.\n", BufferTime);
		//Set a celing for the buffer time.
		if (BufferTime > 500000) BufferTime = 500000;
	}

	/* Depending on the value of BufferTime,
	 * we will be setting some period values.*/
	if(BufferTime > 0)
		//Divide by 4;
		PeriodTime = BufferTime >> 2;
	else
		//Divide by 4;
		FramesPerPeriod = FramesPerBuffer >> 2;


	/* Set number of periods. Periods used to be called fragments. */
	
	/* Do we want to use period time or frames per period.
	 * basicly, are we setting the period size to a number or
	 * using a timeframe to calculate the real size.*/
	if(PeriodTime > 0){
		if((AlsaCallReturnCode = snd_pcm_hw_params_set_period_time_near(PCM_Handle,
			HW_Params,&PeriodTime, 0)) < 0)
		{
			fprintf(stderr, "Error setting period time near: %s.\n",
				snd_strerror(AlsaCallReturnCode));
			return(-1);
		}
	}else{
		if((AlsaCallReturnCode = snd_pcm_hw_params_set_period_size_near(PCM_Handle,
			HW_Params, &FramesPerPeriod, 0)) < 0)
		{
			fprintf(stderr, "Error setting period size near: %s.\n",
				snd_strerror(AlsaCallReturnCode));
			return(-1);
		}
	}


	/* The unit of the buffersize depends on the function. Sometimes it is
	 * given in bytes, sometimes the number of frames have to be specified.
	 * One frame is the sample data vector for all channels. For 16 Bit stereo
	 * data, one frame has a length of four bytes.*/

	/* Use a buffer large enough to hold one period
	 * Set buffer size (in frames). The resulting latency is given by
	 * latency = PeriodSize * Periods / (SampleRate * bytes_per_frame)*/

	/* Do we want to use buffer time or frames per buffer.
	 * basicly, are we setting the buffer size to a number or
	 * using a timeframe to calculate the real size.*/
	if(BufferTime > 0){
		if((AlsaCallReturnCode = snd_pcm_hw_params_set_buffer_time_near(PCM_Handle,
			HW_Params, &BufferTime, 0)) < 0)
		{
			fprintf(stderr, "Error setting buffer time near: %s.\n",
				snd_strerror(AlsaCallReturnCode));
			return(-1);
		}
	}else{
		if((AlsaCallReturnCode = snd_pcm_hw_params_set_buffer_size_near(PCM_Handle,
			HW_Params, &FramesPerBuffer)) < 0)
		{
			fprintf(stderr, "Error setting buffer size near: %s.\n",
				snd_strerror(AlsaCallReturnCode));
			return(-1);
		}
	}


	/* Now we apply the configuration to the PCM device pointed to
	 * by pcm_handle. This will also prepare the PCM device.*/

	/* Apply HW parameter settings to PCM device and prepare device */
	if((AlsaCallReturnCode = snd_pcm_hw_params(PCM_Handle, HW_Params)) < 0){
		fprintf(stderr, "Unable to set hw parameters: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);
	}

	/*Now lets get the real chunk size and buffer size.*/
	if((AlsaCallReturnCode = snd_pcm_hw_params_get_period_size(HW_Params, &PeriodSize, 0)) < 0){
		fprintf(stderr, "Unable to get period size: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);
	}

	if((AlsaCallReturnCode = snd_pcm_hw_params_get_buffer_size(HW_Params, &BufferSize)) < 0){
		fprintf(stderr, "Unable to get Buffer size: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);
	}

	if(BufferSize == PeriodSize){
		fprintf(stderr, "Can't use period size equal to the buffer size "
			"(%lu == %lu)\n", PeriodSize, BufferSize);
		exit(1);
	}


	/*NOW lets set up the software parameters for alsa driver.*/

	if((AlsaCallReturnCode = snd_pcm_sw_params_current(PCM_Handle, SW_Params)) < 0){
		fprintf(stderr, "Unable to get the current software parameters: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}
	
	if((AlsaCallReturnCode = snd_pcm_sw_params_get_xfer_align(SW_Params, &XferAlign)) < 0){
		fprintf(stderr, "Unable to obtain xfer align: %s\n", snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}

	if(MinSleepTime)
		XferAlign = 1;
	
	if((AlsaCallReturnCode = snd_pcm_sw_params_set_sleep_min(PCM_Handle,
		SW_Params, MinSleepTime)) < 0)
	{
		fprintf(stderr, "Unable to set the sleep_min time: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}

	if(AvailableMinSampleCount < 0)
		n = (size_t) PeriodSize;
	else
		n = SampleRate * AvailableMinSampleCount / 1000000;

	if((AlsaCallReturnCode = snd_pcm_sw_params_set_avail_min(PCM_Handle, SW_Params, n)) < 0){
		fprintf(stderr, "Unable to set the avail_min: %s\n", snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}
	
	/* round up to closest transfer boundary */
	n = (BufferSize / XferAlign) * XferAlign;

	if (StartDelay <= 0) {
		StartThreshold = n + ExactRate * StartDelay / 1000000;
	} else
		StartThreshold = ExactRate * StartDelay / 1000000;

	if (StartThreshold < 1)
		StartThreshold = 1;

	if (StartThreshold > n)
		StartThreshold = n;

	if((AlsaCallReturnCode = snd_pcm_sw_params_set_start_threshold(PCM_Handle,
		SW_Params, StartThreshold)) < 0)
	{
		fprintf(stderr, "Unable to set start_threshold: %s\n",
			snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}


	if (StopDelay <= 0) 
		StopThreshold = BufferSize + ExactRate * StopDelay / 1000000;
	else
		StopThreshold = ExactRate * StopDelay / 1000000;


	if((AlsaCallReturnCode = snd_pcm_sw_params_set_stop_threshold(PCM_Handle,
		SW_Params, StopThreshold)) < 0)
	{
		fprintf(stderr, "Unable to set stop_threshold: %s\n", snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}

	if((AlsaCallReturnCode = snd_pcm_sw_params_set_xfer_align(PCM_Handle,
		SW_Params, XferAlign)) < 0)
	{
		fprintf(stderr, "Unable to set Xfer_align: %s\n", snd_strerror(AlsaCallReturnCode));
		exit(1);	//maybe we dont want to exit, but for now just quit. bj
	}


	/* Apply SW parameter settings to PCM device. */
	if((AlsaCallReturnCode = snd_pcm_sw_params(PCM_Handle, SW_Params)) < 0){
		fprintf(stderr, "Unable to set sw parameters: %s\n", snd_strerror(AlsaCallReturnCode));
		exit(1);
	}

	BitsPerSample = snd_pcm_format_physical_width(SND_PCM_FORMAT_S16_LE);
	BitsPerFrame = BitsPerSample * NumberOfChannels;

	//Samples Per Frame;
	SamplesPerFrame = BitsPerFrame / BitsPerSample;
		
	PeriodBytes = PeriodSize * (BitsPerFrame / BITS_PER_BYTE);

	//Set the number of samples per chunck
	SamplesPerPeriod = (PeriodBytes * BITS_PER_BYTE) / BitsPerSample;
	
	return 1;
}


int
AlsaPlay(void *Data, int DataSize){

	int SamplesWritten=0, BytesLoaded=0, TimesThroughLoop=0,
		SamplesPerDataSize = (DataSize * BITS_PER_BYTE) / BitsPerSample;
	unsigned int NumberOfSamplesToWrite=0,
		NumberOfFramesToWrite=0, 
		SamplesLeftToWrite=0;
	char *ptrCurrentDataPosition;
	
//	snd_pcm_prepare(PCM_Handle);

	while((int)PeriodBytes * TimesThroughLoop < DataSize){

		SamplesLeftToWrite = SamplesPerDataSize - SamplesWritten;

		if (SamplesLeftToWrite > SamplesPerPeriod )
			SamplesLeftToWrite = SamplesPerPeriod;
		if (SamplesLeftToWrite == 0) break;

		ptrCurrentDataPosition = Data + PeriodBytes * TimesThroughLoop;
		
		NumberOfFramesToWrite = ((PeriodBytes * BITS_PER_BYTE) / BitsPerFrame);
		NumberOfSamplesToWrite = NumberOfFramesToWrite * SamplesPerFrame;

		if (NumberOfSamplesToWrite > SamplesLeftToWrite )
			NumberOfSamplesToWrite = SamplesLeftToWrite;

		if((AlsaCallReturnCode = snd_pcm_writei(PCM_Handle,
			ptrCurrentDataPosition, NumberOfSamplesToWrite)) <= 0 )
		{
			fprintf(stderr, "Write to audio interface failed: %s\n"
				"Tried To Write = %d\n" "Current State = %d\n",
				snd_strerror(AlsaCallReturnCode), NumberOfSamplesToWrite,
				snd_pcm_state(PCM_Handle));
	
			while ((AlsaCallReturnCode = snd_pcm_writei(PCM_Handle,
				ptrCurrentDataPosition, NumberOfSamplesToWrite)) < 0)
			{
				fprintf(stderr, "<<<<<<<<< Buffer Underrun >>>>>>>>>\n");
				snd_pcm_prepare(PCM_Handle);
			}

		}else{
			if(AlsaCallReturnCode != (int) NumberOfSamplesToWrite){
				fprintf(stderr,
					"AlsaCallReturnCode != NumberOfSamplesToWrite\n");
			}
			fprintf(stderr, "Wrote %d bytes of data to device.\n", AlsaCallReturnCode);
		}

		SamplesWritten += AlsaCallReturnCode;
		BytesLoaded = 0;
		TimesThroughLoop++;
	}

	// Stop PCM device after pending frames have been played
//	snd_pcm_drain(PCM_Handle);
	/* Stop PCM device and drop pending frames */
//	snd_pcm_drop(PCM_Handle);
//	snd_pcm_prepare(PCM_Handle);


	fprintf(stderr, "Leaving Function............\n");
	return 0;
}

--------------030104080708010807060008
Content-Type: text/plain;
 name="Main.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Main.cpp"

#include "Wave.h"

using namespace Audio;

#ifdef __cplusplus
	extern "C" {
#endif

int AlsaConfigure(void);
int AlsaPlay(void *DataToBeWritten, int DataSizeToWrite);

#ifdef __cplusplus
	}
#endif

int
main(){

	Wave wfile;
	
	std::string s="/home/brian/Desktop/Water_Splash.wav";
	
		
	wfile.Open(s);
	
	AlsaConfigure();
	
	unsigned int n=0;
	long m = wfile.GetSize()/40;
	char DestBuffer[m];
	uint32 SizeRead=0;
	
	memset(DestBuffer, 0, m );

	while (n < wfile.GetSize()){

		//Get some data from the wave file.
		if(wfile.Read(DestBuffer, m, &SizeRead)){
			
			if(SizeRead)
				//we only read some of what we wanted, write it to the device.
				AlsaPlay(DestBuffer, SizeRead);
			else
				//we read m bytes, write it to the device.
				AlsaPlay(DestBuffer, m);

			//increment n
			n += m;
		}else{
			//Are we at the eof?
			if(wfile.IsEOF())
				fprintf(stderr, "We are at the end of the file.\n");
			
			//how much data did we get
			if(SizeRead > 0){
				//we got what we were looking for so write it to the device.
				AlsaPlay((short*)DestBuffer, SizeRead);
				//increment n
				n += SizeRead;
			}
		}
	}
	
	wfile.Close();
	return 0;
}


--------------030104080708010807060008--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
